-- truncate database
use DataCentre;

truncate table CacheItem;
truncate table FileLib;
truncate table FileItem;
truncate table FileLibAssignUser;
truncate table FileType;
truncate table MemoryItem;
truncate table MemoryLib;
truncate table MemoryLabel;

use BaseData;
truncate table AgentOrganization;
truncate table AgentWorker;
delete
from AppUser
where Id not in (3588, 349, 1889, 1157);
truncate table AssetsSwapGoods;
INSERT INTO `BaseData`.`AssetsSwapGoods`(`AppChanel`, `Name`, `ToGoodsType`, `Quantity`, `FromGoodsType`, `Price`, `EffectiveDays`, `Description`, `Status`, `StartTime`, `EndTime`, `CreateTime`, `UpdateTime`) VALUES (1, '译小币 -> 翻译字数（1:100 兑换）', 16, 100, 256, 1.00, 18250, '译小币 -> 翻译字数（1:100 兑换）', 1, '2020-03-05 00:00:00.000000', '2050-12-31 23:59:59.000000', NOW(), NOW());
truncate table AssetsSwapRecord;
truncate table AutoRechargePlan;
truncate table ChatGroupRecord;
truncate table ChatTranslateRecord;
truncate table ChatUserRecord;
truncate table Customer;
truncate table CustomerFedback;
truncate table DongleInfo;
truncate table InviteRelation;
truncate table IpAddressWhiteList;
truncate table MachineCodeInfo;
truncate table OpenUser;
truncate table OrderList;
delete
from Organization
where Id not in (1, 1159, 1225, 5668, 4034, 319, 1768, 1107);
truncate table PwdSecurity;
truncate table RechargeRecord;
delete
from SysDataPermissions
where SystemUserId not in (1545,2546,1954,173);
delete
from SystemUser
where Id not in (1545,2546,1954,173);
delete
from SystemUserClaim
where SystemUserId not in (1545,2546,1954,173);
truncate table SystemUserDongleInfo;
delete
from SystemUserRole
where SystemUserId not in (1545,2546,1954,173);
truncate table SystemUserDongleInfo;
delete
from TripartiteAuth
where AppUserId not in (3588, 349, 1889, 1157);
truncate table UserAssetsInfo;
delete
from UserDomainType
where SystemUserId not in (1545,2546,1954,173);
truncate table UserEnDeCrypt;
delete
from UserExtendedInfo
where AppUserId not in (3588, 349, 1889, 1157);
delete
from UserLanguageType
where SystemUserId not in (1545,2546,1954,173);
truncate table UserOperationLog;
truncate table UserPackageInfo;
truncate table UserProductServiceInfo;
truncate table UserRemainInfo;
truncate table WordsBook;

use Auth;
delete  from Auth.Users where Id not  in ('b7793c83-bca3-45c7-9269-7707fa139f4e','5f5b5295-1878-43d3-a0c8-3caa5a4a237f','ad859679-e15f-4d05-88df-3e2e215ad68e','b4d3b1f4-6044-4939-8e0d-74ed0980b1a4');

truncate table UserClaims;
truncate table UserLogins;

use Chat;
set  foreign_key_checks =0;
truncate table Conversations;
truncate table ConversationUsers;
truncate table Messages;
truncate table TranslateMessages;
truncate table Chat.Users;
set  foreign_key_checks =1;