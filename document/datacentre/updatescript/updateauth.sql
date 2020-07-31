




insert into Auth.Users
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount)
    select   OldId, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount
 from BaseData.SystemUser where NormalizedUserName <>'admin';


insert into BaseData.TripartiteAuth (AppUserId, OpenId, TripartiteType, Status)  select AppUserId,OldId,0,1 from BaseData.SystemUser ;




