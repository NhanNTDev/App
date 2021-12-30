using AutoMapper;
using DiCho.Core.Constants;
using DiCho.Core.Custom;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public interface IJWTService
    {
        Task<IdentityResult> CreateUserAsync(AspNetUsersModel model);
        Task<AspNetUsers> UpdateUserAsync(AspNetUsersUpdateModel model, string id);
        Task<TokenModel> Login(AspNetUserLoginModel model);
    }
    public class JWTService : IJWTService
    {
        private readonly UserManager<AspNetUsers> _userManager;
        private readonly SignInManager<AspNetUsers> _signInManager;
        private readonly RoleManager<AspNetRoles> _roleManager;
        private readonly IConfigurationProvider _mapper;
        public JWTService(UserManager<AspNetUsers> userManager, SignInManager<AspNetUsers> signInManager, RoleManager<AspNetRoles> roleManager, IMapper mapper)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _mapper = mapper.ConfigurationProvider;
        }
        private async Task<TokenModel> GenerateToken(string username, IList<string> roles)
        {
            List<string> userRoles = new List<string>(roles);
            var user = await _userManager.FindByNameAsync(username);
            var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, username),
                    new Claim("UserId",user.Id),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                };
            foreach (var role in roles)
                authClaims.Add(new Claim(ClaimTypes.Role, role));
            string secret = AppCoreConstants.SECRECT_KEY;
            string issuer = AppCoreConstants.ISSUE_KEY;
            var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
            var token = new JwtSecurityToken(
                issuer: issuer,
                audience: issuer,
                expires: DateTime.Now.AddMinutes(30),
                claims: authClaims,
                signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
                );
            return new TokenModel
            {
                Token = new JwtSecurityTokenHandler().WriteToken(token),
                Username = username,
                Expires = token.ValidTo,
                TokenType = "Bearer",
                Role = userRoles,
                Id = user.Id,
                ShortName = user.ShortName,
                Name = user.Name,
                Image = user.Image,
                Email = user.Email
            };
        }
        private async Task<RefreshTokenViewModel> GenerateRefreshToken(string username, IList<string> roles)
        {
            List<string> userRoles = new List<string>(roles);
            var user = await _userManager.FindByNameAsync(username);
            var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, username),
                    new Claim("UserId",user.Id),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                };
            foreach (var role in roles)
                authClaims.Add(new Claim(ClaimTypes.Role, role));
            string secret = AppCoreConstants.SECRECT_KEY;
            string issuer = AppCoreConstants.ISSUE_KEY;
            var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
            var token = new JwtSecurityToken(
                issuer: issuer,
                audience: issuer,
                expires: DateTime.Now.AddMonths(1),
                claims: authClaims,
                signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
                );
            return new RefreshTokenViewModel
            {
                Token = new JwtSecurityTokenHandler().WriteToken(token),
                Expires = DateTime.Now.AddMonths(1),
                Created = DateTime.UtcNow,
                Revoked = DateTime.Now,
                Role = userRoles
            };
        }
        public async Task<IdentityResult> CreateUserAsync(AspNetUsersModel model)
        {
            if (model.UserName.Contains(" ") || model.Password.Contains(" "))
            {
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, "No Space is allowed");
            }
            if (model.Role == null)
            {
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, "Role is required");
            }

            var user = new AspNetUsers
            {
                Id = Guid.NewGuid().ToString(),
                Email = model.Email,
                UserName = model.UserName,
                Name = model.Name,
                Address = model.Address,
                Image = model.Image,
                ShortName = model.ShortName,
                Gender = model.Gender,
                DateOfBirth = model.DateOfBirth,
                PhoneNumber = model.PhoneNumber
            };
            List<AspNetRolesModel> roles = model.Role.ToList();
            List<AspNetRoles> allRoles = _roleManager.Roles.ToList();
            foreach (var role in roles)
            {
                if (allRoles.Where(x => x.Id == role.Id && x.Name == role.Name).FirstOrDefault() == null)
                {
                    throw new ErrorResponse((int)HttpStatusCode.BadRequest, "Can not found role:" + role.Name);
                }
            }
            var result = await _userManager.CreateAsync(user, model.Password);
            if (result.Succeeded)
            {
                var token = await _userManager.GenerateEmailConfirmationTokenAsync(user);
                if(!string.IsNullOrEmpty(token))
                {
                    
                }
            }

            var newUser = await _userManager.FindByNameAsync(user.UserName);

            foreach (var role in roles)
            {
                var tmp = await _roleManager.FindByNameAsync(role.Name);
                var result2 = await _userManager.AddToRoleAsync(newUser, tmp.Name);
                await _userManager.IsInRoleAsync(user, role.Name);
                await _userManager.AddToRoleAsync(user, role.Name);
            }
            return result;
        }
        public async Task<AspNetUsers> UpdateUserAsync(AspNetUsersUpdateModel model, string id)
        {
            var entity = await _userManager.FindByIdAsync(id);
            if (model.Id != id)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, "Id not matched");
            if (model.Id != id || entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, "Can not find");
            var updateEntity = _mapper.CreateMapper().Map(model, entity);
            await _userManager.UpdateAsync(updateEntity);
            return updateEntity;
        }
        public async Task<TokenModel> Login(AspNetUserLoginModel model)
        {
            var user = await _userManager.FindByNameAsync(model.UserName);
            if (user == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, "Username not found");
            var valid = await _signInManager.UserManager.CheckPasswordAsync(user, model.Password);
            if (!valid)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, "Wrong password");
            var token = await _userManager.GetAuthenticationTokenAsync(user, "Login", user.UserName);
            var roles = await _userManager.GetRolesAsync(user);
            if (token == null)
            {
                var newToken = await GenerateToken(user.UserName, roles);
                token = newToken.Token;
                var result = await _userManager.SetAuthenticationTokenAsync(user, "Login", user.UserName, newToken.Token);
                if (result.Succeeded)
                    return newToken;
                return null;
            }
            var expires = new JwtSecurityTokenHandler().ReadToken(token).ValidTo;
            if (DateTime.Now < expires)
                return new TokenModel
                {
                    Token = token,
                    Role = new List<string>(roles),
                    TokenType = "Bearer",
                    Username = user.UserName,
                    Expires = expires,
                    ShortName = user.ShortName,
                    Name = user.Name,
                    Image = user.Image,
                    Id = user.Id,
                    Email = user.Email
                };
            var createToken = await GenerateToken(user.UserName, roles);
            var createResult = await _userManager.SetAuthenticationTokenAsync(user, "Login", user.UserName, createToken.Token);
            if (createResult.Succeeded)
                return createToken;
            return null;
        }
    }
}
