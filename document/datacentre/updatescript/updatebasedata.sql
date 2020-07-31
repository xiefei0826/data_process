use BaseData;
UPDATE BaseData.AppUser set Id=Id+3000 WHERE Id in (349,1889);

UPDATE BaseData.AppUser set Id=349 WHERE OldId='96370414-7ae9-4ea9-8754-417f3d54faed';

UPDATE BaseData.AppUser set Id=1889 WHERE OldId='161855a1-e531-421e-bcdf-538188d1a581';

UPDATE BaseData.AppUser set Id=3588 WHERE OldId='45fa085f-7178-4640-bb73-06dc0e10627a';




UPDATE BaseData.Organization set Id=Id+3000 WHERE Id in (319,1159,1225,1768);

UPDATE BaseData.Organization set Id=319 WHERE OldId='405b4517-01e1-4d5a-88a8-0d8929862e1f';

UPDATE BaseData.Organization set Id=1159 WHERE OldId='b57e38a2-c084-42d4-bc8c-34680b4a0111';

UPDATE BaseData.Organization set Id=1225 WHERE OldId='3caab6dd-8eb9-430d-91be-37577a0f1bd5';

UPDATE BaseData.Organization set Id=1768 WHERE OldId='f1bda624-6bc5-4ba0-ba14-4fdb286de8f5';

UPDATE BaseData.Organization set Id=5668 WHERE OldId='6b248c00-3baf-4b9f-a7f6-fd9b61288697';



UPDATE BaseData.SystemUser set Id=Id+3000 WHERE Id in (173,1545,1954);

UPDATE BaseData.SystemUser set Id=173 WHERE OldId='b7793c83-bca3-45c7-9269-7707fa139f4e';

UPDATE BaseData.SystemUser set Id=1545 WHERE OldId='5f5b5295-1878-43d3-a0c8-3caa5a4a237f';

UPDATE BaseData.SystemUser set Id=1954 WHERE OldId='ad859679-e15f-4d05-88df-3e2e215ad68e';


use BaseData;
update Organization as a ,Organization as b set a.ParentId=b.Id where a.OldParentId=b.OldId and a.OldParentId <>'' and a.ParentId=0;

update AppUser as a ,Organization as b set a.OrganizationId=b.Id where a.OldOrganizationId=b.OldId and a.OrganizationId=0;

update SystemUser as a ,AppUser as b set a.AppUserId=b.Id where a.OldAppUserId=b.OldId and a.AppUserId=0;

update SystemUser as a ,AppUser as b set a.AppUserId=b.Id where a.OldAppUserId=b.OldId and a.AppUserId=0;


update  AssetsSwapRecord as a , AssetsSwapGoods as b  set a.AssetsSwapGoodsId=b.Id where a.OldAssetsSwapGoodsId=b.OldId and  a.AssetsSwapGoodsId=0 ;

update  AssetsSwapRecord as a , AppUser as b  set a.AssetsSwapGoodsId=b.Id where  a.OldUserId=b.OldId and a.AssetsSwapGoodsId=0 ;

update ChatUserRecord as a , AppUser as b ,AppUser as c set a.FromUserId=b.Id,a.ToUserId=c.Id where a.OldFromUserId=b.OldId and a.OldToUserId=c.OldId;

update Customer as a ,Organization as b set a.OrganizationId=b.Id  where a.OldOrganizationId=b.OldId and a.OrganizationId=0;

update DomainTypeLanguageType as a ,DomainType as b set a.DomainTypeId=b.Id where a.OldDomainTypeId=b.OldId and a.DomainTypeId=0;

update IpAddressWhiteList as a ,Organization as b  set a.OrganizationId=b.Id where a.OldOrganizationId=b.OldId and OrganizationId=0;

update MachineCodeInfo as a ,SystemUser as b  set a.SystemUserId=b.Id where a.OldUserId=b.OldId and SystemUserId=0;

update OrderList as a ,Goods as b  set a.GoodsId=b.Id where  a.OldGoodsId=b.OldId and a.GoodsId=0;

update OrderList as a ,SystemUser as b set a.SystemUserId=b.Id where a.OldUserId=b.OldId and a.SystemUserId=0;

update RechargeRecord as a , AppUser as b set a.AppUserId=b.Id,a.OrganizationId=b.OrganizationId where a.OldUserId=b.OldId and a.AppUserId=0;
update RechargeRecord as a , AppUser as b set a.OperatorUserId=b.Id where a.OldOperatorUserId=b.OldId and a.OperatorUserId=0;


update ServiceEngine as a ,ServiceProvider as b set a.ServiceProviderId=b.Id where a.OldServiceProviderId=b.OldId and a.ServiceProviderId=0;

update SysDataPermissions as a , SystemUser as b set a.SystemUserId=b.Id where a.OldUserId=b.OldId and a.SystemUserId=0;
update SysDataPermissions as a , SystemUser as b set a.DataPermId=b.Id where a.OldDataPermId=b.OldId and DataPermId=0;

update SysResRight as a , SystemRole as b set a.SysRoleId=b.Id where a.OldSysRoleId=b.OldId and a.SysRoleId=0;
update SysResRight as a ,SysResource as b set a.SysResourceId=b.Id where a.OldSysResourceId=b.OldId and a.SysResourceId=0;

update SystemRoleClaim as a , SystemRole as b set a.RoleId=b.Id where  a.OldRoleId=b.OldId and a.RoleId=0;

update SystemUserClaim as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;

update SystemUserDongleInfo as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;

update SystemUserDongleInfo as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;
update SystemUserDongleInfo as a , DongleInfo as b set a.DongleId=b.Id where  a.OldDongleId=b.OldId and a.DongleId=0;

update SystemUserLogin as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;

update SystemUserRole as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;
update SystemUserRole as a , SystemRole as b set a.RoleId=b.Id where  a.OldRoleId=b.OldId and a.RoleId=0;

update UserAssetsInfo as a ,Organization as b set a.OrganizationId=b.Id where a.OldOrganizationId=b.OldId  and a.OrganizationId=0;
update UserAssetsInfo as a ,AppUser as b set a.AppUserId=b.Id where a.OldUserId=b.OldId  and a.AppUserId=0;

update UserDomainType as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;
update UserDomainType as a , DomainType as b set a.DomainTypeId=b.Id where  a.OldDomainTypeId=b.OldId and a.DomainTypeId=0;

update UserEnDeCrypt as a ,SystemUser as b set a.SystemUserId=b.Id where a.OldUserId=b.OldId  and a.SystemUserId=0;

update UserExtendedInfo as a , AppUser as b set a.AppUserId=b.Id where  a.OldUserId=b.OldId and a.AppUserId=0;

update UserLanguageType as a , SystemUser as b set a.SystemUserId=b.Id where  a.OldUserId=b.OldId and a.SystemUserId=0;

update UserOperationLog as a ,AppUser as b set a.AppUserId=b.Id where a.OldUserId=b.OldId  and a.AppUserId=0;
update UserOperationLog as a ,Organization as b set a.OrganizationId=b.Id where a.OldOrganizationId=b.OldId  and a.OrganizationId=0;

update UserProductServiceInfo as a , AppUser as b set a.AppUserId=b.Id where  a.OldUserId=b.OldId and a.AppUserId=0;
update UserProductServiceInfo as a ,Organization as b set a.OrganizationId=b.Id where a.OldOrganizationId=b.OldId  and a.OrganizationId=0;

update UserRemainInfo as a , AppUser as b set a.AppUserId=b.Id where  a.OldUserId=b.OldId and a.AppUserId=0;

update WordsBook as a ,AppUser as b set a.AppUserId=b.Id where a.OldUserId=b.OldId  ;
update WordsBook as a ,Organization as b set a.OrganizationId=b.Id where a.OldOrganizationId=b.OldId and a.OrganizationId=0;
update SystemInfo as  a  , Organization as b  set a.Value=b.Id  where a.Type=19 and a.Value =b.OldId;


update AgentWorker as a ,AgentOrganization as b set a.AgentOrganizationId=b.Id where a.OldAgentOrganizationId=b.OldId;


update  SystemInfo  as a , Organization as b  set a.Value=b.Id where a.Type=1 and a.Value=b.OldId;
