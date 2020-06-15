#!/bin/bash

./mysqltohivetable.sh DataCentre xf xiefei 'jdbc:mysql://tdb:3306/DataCentre?characterEncoding%3dutf8mb4' 'hdfs://ld1:8020'
./mysqltohivetable.sh BaseData xf xiefei 'jdbc:mysql://tdb:3306/BaseData?characterEncoding%3dutf8mb4' 'hdfs://ld1:8020'

nohup ./mysqltohdfs.sh DataCentre CacheItem,FileItem,FileLib,FileType,Label,LanguageType,MemoryItem,MemoryLabel,MemoryLib,NcovActivity,ProductLabel,QueryCount,QueryLog,SystemInfo,TranslateConsume,TranslationEnginePrice,UserRemainWord xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://tdb:3306/DataCentre?characterEncoding%3dutf8mb4' >/dev/null 2>&1 &

nohup ./mysqltohdfs.sh BaseData AgentOrganization,AgentWorker,AppUser,AssetsSwapGoods,AssetsSwapRecord,AutoRechargePlan,ChatGroupRecord,ChatTranslateRecord,ChatUserRecord,Currency,Customer,CustomerFedback,DomainType,DomainTypeLanguageType,DongleInfo,ExtendedColumnInfo,Goods,InviteRelation,IpAddressWhiteList,MachineCodeInfo,OpenUser,OrderList,Organization,PayWay,PayWayCurrency,RechargeRecord,ServiceEngine,ServiceProvider,SysDataPermissions,SysMenu,SysResRight,SysResource,SystemInfo,SystemRole,SystemRoleClaim,SystemUser,SystemUserClaim,SystemUserDongleInfo,SystemUserLogin,SystemUserRole,SystemUserToken,TripartiteAuth,UserAssetsInfo,UserDomainType,UserEnDeCrypt,UserExtendedInfo,UserLanguageType,UserOperationLog,UserPackageInfo,UserProductServiceInfo,UserRemainInfo,WordsBook xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://tdb:3306/BaseData?characterEncoding%3dutf8mb4' >/dev/null 2>&1 &

# export TERM=xterm-color
