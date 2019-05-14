--CREATE TABLE student  --学生信息表
--(
--  stuID CHAR(10) primary key,  --学生编号
--  stuName  CHAR(10) NOT NULL ,     --学生名称
--  major  CHAR(50) NOT NULL    --专业
--)
--GO
--CREATE TABLE book  --图书表
--(
--  BID  CHAR(10) primary key,    --图书编号
--  title  CHAR(50) NOT NULL,  --书名
--  author  CHAR(20) NOT NULL,  --作者
--)
--GO
--CREATE TABLE borrow  --借书表
--(
-- borrowID  CHAR(10) primary key,    --借书编号
--stuID CHAR(10) foreign key(stuID) references student(stuID), --学生编号
--BID  CHAR(10) foreign key(BID) references book(BID),--图书编号
-- T_time  datetime NOT NULL,   --借出日期
-- B_time  datetime    --归还日期
--)
--GO

----学生信息表中插入数据--
--INSERT INTO student(stuID,stuName,major)VALUES('1001','林林','计算机')
--INSERT INTO student(stuID,stuName,major)VALUES('1002','白杨','计算机')
--INSERT INTO student(stuID,stuName,major)VALUES('1003','虎子','英语')
--INSERT INTO student(stuID,stuName,major)VALUES('1004','北漂的雪','工商管理')
--INSERT INTO student(stuID,stuName,major)VALUES('1005','五月','数学')
----图书信息表中插入数据--
--INSERT INTO book(BID,title,author)VALUES('B001','人生若只如初见','安意如')
--INSERT INTO book(BID,title,author)VALUES('B002','入学那天遇见你','晴空')
--INSERT INTO book(BID,title,author)VALUES('B003','感谢折磨你的人','如娜')
--INSERT INTO book(BID,title,author)VALUES('B004','我不是教你诈','刘庸')
--INSERT INTO book(BID,title,author)VALUES('B005','英语四级','白雪')
----借书信息表中插入数据--
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T001','1001','B001','2007-12-26',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T002','1004','B003','2008-1-5',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T003','1005','B001','2007-10-8','2007-12-25')
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T004','1005','B002','2007-12-16','2008-1-7')
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T005','1002','B004','2007-12-22',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T006','1005','B005','2008-1-6',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T007','1002','B001','2007-9-11',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T008','1005','B004','2007-12-10',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T009','1004','B005','2007-10-16','2007-12-18')
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T010','1002','B002','2007-9-15','2008-1-5')
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T011','1004','B003','2007-12-28',null)
--INSERT INTO borrow(borrowID,stuID,BID,T_time,B_time)VALUES('T012','1002','B003','2007-12-30',null)

--CREATE TABLE ProWage  --程序员工资表
--(
--  ID int identity(1,1) primary key,  --工资编号
--  PName  CHAR(10) NOT NULL ,     --程序员姓名
--  Wage  int NOT NULL    --工资
--)
--GO
--插入数据--
--INSERT INTO ProWage(PName,Wage)VALUES('来棱',1900)
--INSERT INTO ProWage(PName,Wage)VALUES('张三',1200)
--INSERT INTO ProWage(PName,Wage)VALUES('李四',1800)
--INSERT INTO ProWage(PName,Wage)VALUES('二月',3500)
--INSERT INTO ProWage(PName,Wage)VALUES('蓝天',2780)

select * from ProWage

if exists(select*from sysobjects where name='Sum_wages')
drop procedure Sum_wages
go 
create procedure Sum_wages
@pWage int,
@aWage int,
@total int
as
 declare @countAll int,@countHg int
set @countAll =(select COUNT(*) from ProWage)
while (1=1)
begin 
set @countHg= (select COUNT(*) from ProWage where wage < @pWage)
if( @countAll < 2*@countHg)
update ProWage set @total = @total + @aWage,wage = wage + @aWage
ELSE
break
end
print '一共加了：'+convert(varchar,@total)
print '加薪后员工的薪资'
select *from ProWage

exec Sum_wages @PWage=2800,@AWage=100,@total=0


--银行系统ATM存取款操作--存储过程
  --创建数据表
--create table userInfo  --建立用户信息表
--(
-- customerID int identity(1,1) primary key,--顾客编号
-- customerName varchar(20) not null,--开户名
-- PID numeric not null,--身份证号
-- telephone varchar(30) not null,--联系电话
-- userAddress varchar(100)--居住地址
--)
--go

--alter table userInfo add constraint UK_PID unique(PID)
--alter table userInfo add constraint CK_PID check(len(PID)=15 or len(PID)=18)
--alter table userInfo add constraint CK_telephone check(telephone like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or len(telephone)=11)
--go

--create table cardInfo  --建立银行卡信息表
--(
--cardID varchar(30) primary key,--卡号
--curType varchar(10) not null,--货币种类
--savingType varchar(20),--存款类型
--openDate datetime not null,--开户日期
--openMoney money not null,--开户金额
--balance money not null,--余额
--pass int not null,--密码
--IsReportLoss bit not null,--是否挂失
--customerID int not null--顾客编号
--)
--go
--alter table cardInfo add constraint CK_cardID check(cardID like '1010 3576 [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
--alter table cardInfo add constraint DF_curType default('RMB') for curType
--alter table cardInfo add constraint CK_savingType check(savingType in ('活期','定活两便','定期'))
--alter table cardInfo add constraint DF_openDate default(getdate()) for openDate
--alter table cardInfo add constraint CK_openMoney check(openMoney>=1)
--alter table cardInfo add constraint CK_balance check(balance>=1)
--alter table cardInfo add constraint CK_pass check(len(pass)=6)
--alter table cardInfo add constraint DF_pass default(888888) for pass
--alter table cardInfo add constraint DF_IsReportLoss default(0) for IsReportLoss
--alter table cardInfo add constraint FK_customerID foreign key(customerID) references userInfo(customerID)
--go

--create table transInfo  --建立交易信息表
--(
-- transDate datetime not null,--交易日期
-- cardID varchar(30) not null,--卡号
-- transType varchar(10) not null,--交易类型
-- transMoney money not null,--交易金额
-- remark varchar(100) --备注
--)
--go

--alter table transInfo add constraint DF_transDate default(getdate()) for transDate
--alter table transInfo add constraint FK_cardID foreign key(cardID) references cardInfo(cardID)
--alter table transInfo add constraint CK_transType check(transType='存取' or transType='支取')
--alter table transInfo add constraint CK_transMoney check(transMoney>0)
--go


--insert into userInfo(customerName,PID,telephone,userAddress) values('张三',123456789012345,'010-67898978','北京海淀')
--insert into userInfo(customerName,PID,telephone,userAddress) values('李四',321245678912345678,'027-67898978','武汉江岸区')
--insert into userInfo(customerName,PID,telephone,userAddress) values('王五',221245678912345672,'021-67898978','上海浦东区')
--insert into userInfo(customerName,PID,telephone,userAddress) values('赵六',521245678912345675,'13178910771','合肥肥西区')
--go

--insert into cardInfo(cardID,savingType,openMoney,balance,pass,customerID) 
--values('1010 3576 1234 5678','活期',1000,1000,123123,1)
--insert into cardInfo(cardID,savingType,openMoney,balance,pass,customerID) 
--values('1010 3576 1212 1134','定期',1,1,321321,2)
--insert into cardInfo(cardID,savingType,openMoney,balance,customerID) 
--values('1010 3576 1256 2235','定活两便',50,50,3)
--insert into cardInfo(cardID,savingType,openMoney,balance,customerID) 
--values('1010 3576 1358 3221','活期',500,500,4)
--go

--insert into transInfo(transDate,transType,cardID,transMoney) values(getdate(),'支取','1010 3576 1234 5678',900)
--update cardInfo set balance=balance-900 where customerID=1

--insert into transInfo(transDate,transType,cardID,transMoney) values(getdate(),'存取','1010 3576 1212 1134',5000)
--update cardInfo set balance=balance+5000 where customerID=2

--update cardInfo set IsReportLoss=1 where cardID='1010 3576 1212 1134'
--update cardInfo set IsReportLoss=1 where cardID='1010 3576 1256 2235'


select * from userInfo 
select * from cardInfo
select * from transInfo

--自动生成卡号
create  procedure  sp_randCardID
@randCardId char(19) output
as 
declare @ran numeric(16,8)
set @ran = rand((datepart(mm,getDate())*1000) + (datepart(ss,getDate())*1000) + datepart(ms,getdate()))
select @randCardId = '20190424' + SUBSTRING(CAST(@ran as varchar),3,4) + ''+ SUBSTRING(CAST(@ran as varchar),4,4)
go
declare @myCardId char(19)
execute sp_randCardID @myCardId output
print '我的卡号为：'+@myCardId

--开户存储过程

select * from userInfo 
select * from cardInfo
select * from transInfo
delete from userInfo where customerID = 22
drop proc sp_openCount
create proc sp_openCount
@customerName varchar(30),
@cardID char(19),
@PID  char(19),
@telephone char(11),
@openMoney money,
@pass char(6),
@userAddress varchar(40),
@savingType char(10)
as
begin tran
if(@openMoney >=1)
begin
insert into userInfo (customerName,PID,telephone,userAddress)
values (@customerName,@PID,@telephone,@userAddress)
declare @Identtity int,@balance money,@error int
set @balance = @openMoney
select @Identtity=customerID from userInfo where PID = @PID
set @error = @@ERROR
insert into cardInfo (cardID,savingType,openDate,openMoney,pass,balance,customerID)
values (@cardID,@savingType,GETDATE(),@openMoney,@pass,@balance,@Identtity)
set @error =@error + @@ERROR
if (@error =0)
print 'congratulation!you have open then bank card successful'
commit tran
if(@error > 0)
rollback tran
end
else
print 'alert！ money less 1 RMB'
go


--开户卡
begin
begin  tran
declare @myCardId char(19),@error int
execute sp_randCardID @myCardId output
execute sp_openCount 'jokes',@myCardId,360731199805266583,15170038820,500,'123456','杭州西湖区','活期'
set @error = @@ERROR
if(@error > 0)
rollback TRANSACTION
else 
commit TRANSACTION
end

--存钱取钱存储过程
exec sp_takeMoney 2019042413533536,50000,'存取',123456
drop proc   sp_takeMoney
create proc sp_takeMoney
@cardID char(19),
@money money,
@transType char(10),
@inputPass varchar(50)
as
declare @balance money,@existCard int 
select @existCard =COUNT(*)from cardInfo where cardID = @cardID
if (@existCard > 0)
begin 
declare @pass char(20)
select @pass=pass from cardInfo where cardID = @cardID
if(@inputPass = @pass)
begin 
select @balance=balance from cardInfo where cardID = @cardID
begin tran
if(@transType = '存取')
begin
print '交易正在处理，请耐心等待........'
declare @error int
insert into transInfo (transDate,cardID,transType,transMoney)
values(GETDATE(),@cardID,@transType,@money)
set @error = @@ERROR
set @balance = @balance + @money;
update cardInfo set balance = @balance where cardID = @cardID
set @error = @error + @@ERROR
if (@error = 0)
begin
commit tran
print '交易成功！'
print '卡号：'+convert(varchar(50),@cardID)+ ',余额：'+convert(varchar(50),@balance)
end
else if(@error  > 0)
begin
rollback tran
print '交易失败！'
end
end
if(@transType = '支取')
begin
set @error = 0


print '交易正在处理中，请耐心等待........'
insert into transInfo (transDate,cardId,transType,transMoney)
values(GETDATE(),@cardID,@transType,@money)
set @error = @@ERROR
set @balance=@balance-@money
if(@balance < 0)
begin
print '交易失败，您的账户余额不足！'
end
else
begin
update cardInfo set balance = @balance where cardID = @cardID
set @error = @error + @@ERROR
if(@error >0)
begin
rollback tran
print '交易失败！'
print '卡号：'+convert(varchar(50),@cardID) + ',余额为：'+convert(varchar(50),@balance)
end
else
begin
commit tran 
print '交易成功！'
print '卡号：'+convert(varchar(50),@cardID) + ',余额为：'+convert(varchar(50),@balance)
end
end

end
end
else
print '密码错误！'
end
else
begin
print '卡号不存在！请检查是否输入正确'
set @error = 1
end
go

--转账存储过程
select * from userInfo 
select * from cardInfo
select * from transInfo
drop proc sp_transfer
exec sp_transfer 2019042462992994,2019042413533536,2,456878
create proc sp_transfer
@cardID_owner char(19),
@cardID_Got char(19),
@transMoney money,
@openPass char(10)
as
begin tran
declare @error int
exec sp_takeMoney @cardID_owner,@transMoney,'支取',@openPass
set @error = @@ERROR
if(@error >0)
begin 
rollback tran
print '交易失败！'
end
else 
begin
  set @error = 0
  print '转账交易正在处理中，请等待......'
  declare @existCard int 
  select @existCard =COUNT(*)from cardInfo where cardID = @cardID_Got
  if(@existCard > 0)
  begin
  insert into transInfo (transDate,cardID,transType,transMoney)
  values(GETDATE(),@cardID_Got,'存取',@transMoney)
  set @error =  @@ERROR
  declare @balance money
  select @balance = balance from cardInfo where cardID = @cardID_Got
  set @balance = @balance + @transMoney
  update cardInfo set balance = @balance where cardID = @cardID_Got
  set @error = @error + @@ERROR
  if(@error > 0)
  begin
  rollback tran 
  print '交易失败！'
  end
  else
  begin
  commit tran
  print '交易成功！交易金额：'+ convert(varchar,@transMoney) + '元'
  print '卡号：'+convert(varchar,@cardID_Got) +'，余额：'+convert(varchar,@balance)
  end
  end
  else
  begin
  rollback tran
  print '交易失败！转账卡号不存在'
  end
end
go







