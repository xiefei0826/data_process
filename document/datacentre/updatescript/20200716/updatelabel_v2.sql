drop table if exists DataCentre.TmpProductLabel;
create table DataCentre.TmpProductLabel
select *
from DataCentre.ProductLabel;
drop table if exists DataCentre.TmpMemoryLabel;
create table DataCentre.TmpMemoryLabel
select *
from DataCentre.MemoryLabel;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = b.Name
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;



update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '土木建筑'
                                        and b.Name = '建筑'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '钢铁冶金'
                                        and b.Name = '冶金'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '食品饮料'
                                        and b.Name = '食品'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '木材家具'
                                        and b.Name = '家具'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '印刷'
                                        and b.Name = '造纸印刷'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = 'IT'
                                        and b.Name = 'IT互联网'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '影视'
                                        and b.Name = '影视动画'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '体育'
                                        and b.Name = '体育赛事'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;


update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '电力能源'
                                        and b.Name = '火电风电'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name in ('服装', '皮革')
                                        and b.Name = '服装皮革'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '知识产权'
                                        and b.Name = '专利'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '保险证券'
                                        and b.Name = '保险'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '文化艺术'
                                        and b.Name = '音乐美术'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '小说'
                                        and b.Name = '小说图书'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '交通运输'
                                        and b.Name = '市政路桥'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '烟草'
                                        and b.Name = '材料'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '广告'
                                        and b.Name = '广告'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '电竞游戏'
                                        and b.Name = '电竞游戏'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name in ('交流对话', '进出口贸易', '跨境电商')
                                        and b.Name = '商务交流'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name in ('教育培训', '营销管理', '跨境电商')
                                        and b.Name = '教育管理'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;
update DataCentre.ProductLabel as a ,(select a.id as Old, b.Id as New
                                      from DataCentre.Label as a,
                                           DataCentre.Label as b
                                      where a.Name = '船舶工业'
                                        and b.Name = '海洋船舶'
                                        and a.Status = 2
                                        and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;


# ----------------------


update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = b.Name
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;



update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '土木建筑'
                                       and b.Name = '建筑'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '钢铁冶金'
                                       and b.Name = '冶金'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '食品饮料'
                                       and b.Name = '食品'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '木材家具'
                                       and b.Name = '家具'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '印刷'
                                       and b.Name = '造纸印刷'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = 'IT'
                                       and b.Name = 'IT互联网'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '影视'
                                       and b.Name = '影视动画'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '体育'
                                       and b.Name = '体育赛事'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;


update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '电力能源'
                                       and b.Name = '火电风电'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name in ('服装', '皮革')
                                       and b.Name = '服装皮革'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '知识产权'
                                       and b.Name = '专利'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '保险证券'
                                       and b.Name = '保险'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '文化艺术'
                                       and b.Name = '音乐美术'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '小说'
                                       and b.Name = '小说图书'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '交通运输'
                                       and b.Name = '市政路桥'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '烟草'
                                       and b.Name = '材料'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '广告'
                                       and b.Name = '广告'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '电竞游戏'
                                       and b.Name = '电竞游戏'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;


update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name in ('交流对话', '进出口贸易', '跨境电商')
                                       and b.Name = '商务交流'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name in ('教育培训', '营销管理', '留学移民')
                                       and b.Name = '教育管理'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '船舶工业'
                                       and b.Name = '海洋船舶'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;


update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '轻工纺织'
                                       and b.Name = '材料'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

update DataCentre.MemoryLabel as a ,(select a.id as Old, b.Id as New
                                     from DataCentre.Label as a,
                                          DataCentre.Label as b
                                     where a.Name = '法律'
                                       and b.Name = '法律法规'
                                       and a.Status = 2
                                       and b.Status = 1) b
set a.LabelId=b.New
where a.LabelId = b.Old;

# update DataCentre.Label set Status=Status+1;

select *
from DataCentre.Label as a,
     DataCentre.ProductLabel as b
where a.Status = 2
  and a.Id = b.LabelId;


select *
from DataCentre.Label as a,
     DataCentre.MemoryLabel as b
where a.Status = 2
  and a.Id = b.LabelId;

# update DataCentre.MemoryLabel as a ,DataCentre.TmpMemoryLabel as b set a.LabelId=b.LabelId where a.Id=b.Id;
# update DataCentre.ProductLabel as a ,DataCentre.TmpProductLabel as b set a.LabelId=b.LabelId where a.Id=b.Id;
