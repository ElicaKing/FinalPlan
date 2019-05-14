--CREATE TABLE student  --ѧ����Ϣ��
--(
--  stuID CHAR(10) primary key,  --ѧ�����
--  stuName  CHAR(10) NOT NULL ,     --ѧ������
--  major  CHAR(50) NOT NULL    --רҵ
--)
--GO
--CREATE TABLE book  --ͼ���
--(
--  BID  CHAR(10) primary key,    --ͼ����
--  title  CHAR(50) NOT NULL,  --����
--  author  CHAR(20) NOT NULL,  --����
--)
--GO
--CREATE TABLE borrow  --�����
--(
-- borrowID  CHAR(10) primary key,    --������
--stuID CHAR(10) foreign key(stuID) references student(stuID), --ѧ�����
--BID  CHAR(10) foreign key(BID) references book(BID),--ͼ����
-- T_time  datetime NOT NULL,   --�������
-- B_time  datetime    --�黹����
--)
--GO

----ѧ����Ϣ���в�������--
--INSERT INTO student(stuID,stuName,major)VALUES('1001','����','�����')
--INSERT INTO student(stuID,stuName,major)VALUES('1002','����','�����')
--INSERT INTO student(stuID,stuName,major)VALUES('1003','����','Ӣ��')
--INSERT INTO student(stuID,stuName,major)VALUES('1004','��Ư��ѩ','���̹���')
--INSERT INTO student(stuID,stuName,major)VALUES('1005','����','��ѧ')
----ͼ����Ϣ���в�������--
--INSERT INTO book(BID,title,author)VALUES('B001','������ֻ�����','������')
--INSERT INTO book(BID,title,author)VALUES('B002','��ѧ����������','���')
--INSERT INTO book(BID,title,author)VALUES('B003','��л��ĥ�����','����')
--INSERT INTO book(BID,title,author)VALUES('B004','�Ҳ��ǽ���թ','��ӹ')
--INSERT INTO book(BID,title,author)VALUES('B005','Ӣ���ļ�','��ѩ')
----������Ϣ���в�������--
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

--CREATE TABLE ProWage  --����Ա���ʱ�
--(
--  ID int identity(1,1) primary key,  --���ʱ��
--  PName  CHAR(10) NOT NULL ,     --����Ա����
--  Wage  int NOT NULL    --����
--)
--GO
--��������--
--INSERT INTO ProWage(PName,Wage)VALUES('����',1900)
--INSERT INTO ProWage(PName,Wage)VALUES('����',1200)
--INSERT INTO ProWage(PName,Wage)VALUES('����',1800)
--INSERT INTO ProWage(PName,Wage)VALUES('����',3500)
--INSERT INTO ProWage(PName,Wage)VALUES('����',2780)

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
print 'һ�����ˣ�'+convert(varchar,@total)
print '��н��Ա����н��'
select *from ProWage

exec Sum_wages @PWage=2800,@AWage=100,@total=0


--����ϵͳATM��ȡ�����--�洢����
  --�������ݱ�
--create table userInfo  --�����û���Ϣ��
--(
-- customerID int identity(1,1) primary key,--�˿ͱ��
-- customerName varchar(20) not null,--������
-- PID numeric not null,--���֤��
-- telephone varchar(30) not null,--��ϵ�绰
-- userAddress varchar(100)--��ס��ַ
--)
--go

--alter table userInfo add constraint UK_PID unique(PID)
--alter table userInfo add constraint CK_PID check(len(PID)=15 or len(PID)=18)
--alter table userInfo add constraint CK_telephone check(telephone like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or len(telephone)=11)
--go

--create table cardInfo  --�������п���Ϣ��
--(
--cardID varchar(30) primary key,--����
--curType varchar(10) not null,--��������
--savingType varchar(20),--�������
--openDate datetime not null,--��������
--openMoney money not null,--�������
--balance money not null,--���
--pass int not null,--����
--IsReportLoss bit not null,--�Ƿ��ʧ
--customerID int not null--�˿ͱ��
--)
--go
--alter table cardInfo add constraint CK_cardID check(cardID like '1010 3576 [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
--alter table cardInfo add constraint DF_curType default('RMB') for curType
--alter table cardInfo add constraint CK_savingType check(savingType in ('����','��������','����'))
--alter table cardInfo add constraint DF_openDate default(getdate()) for openDate
--alter table cardInfo add constraint CK_openMoney check(openMoney>=1)
--alter table cardInfo add constraint CK_balance check(balance>=1)
--alter table cardInfo add constraint CK_pass check(len(pass)=6)
--alter table cardInfo add constraint DF_pass default(888888) for pass
--alter table cardInfo add constraint DF_IsReportLoss default(0) for IsReportLoss
--alter table cardInfo add constraint FK_customerID foreign key(customerID) references userInfo(customerID)
--go

--create table transInfo  --����������Ϣ��
--(
-- transDate datetime not null,--��������
-- cardID varchar(30) not null,--����
-- transType varchar(10) not null,--��������
-- transMoney money not null,--���׽��
-- remark varchar(100) --��ע
--)
--go

--alter table transInfo add constraint DF_transDate default(getdate()) for transDate
--alter table transInfo add constraint FK_cardID foreign key(cardID) references cardInfo(cardID)
--alter table transInfo add constraint CK_transType check(transType='��ȡ' or transType='֧ȡ')
--alter table transInfo add constraint CK_transMoney check(transMoney>0)
--go


--insert into userInfo(customerName,PID,telephone,userAddress) values('����',123456789012345,'010-67898978','��������')
--insert into userInfo(customerName,PID,telephone,userAddress) values('����',321245678912345678,'027-67898978','�人������')
--insert into userInfo(customerName,PID,telephone,userAddress) values('����',221245678912345672,'021-67898978','�Ϻ��ֶ���')
--insert into userInfo(customerName,PID,telephone,userAddress) values('����',521245678912345675,'13178910771','�Ϸʷ�����')
--go

--insert into cardInfo(cardID,savingType,openMoney,balance,pass,customerID) 
--values('1010 3576 1234 5678','����',1000,1000,123123,1)
--insert into cardInfo(cardID,savingType,openMoney,balance,pass,customerID) 
--values('1010 3576 1212 1134','����',1,1,321321,2)
--insert into cardInfo(cardID,savingType,openMoney,balance,customerID) 
--values('1010 3576 1256 2235','��������',50,50,3)
--insert into cardInfo(cardID,savingType,openMoney,balance,customerID) 
--values('1010 3576 1358 3221','����',500,500,4)
--go

--insert into transInfo(transDate,transType,cardID,transMoney) values(getdate(),'֧ȡ','1010 3576 1234 5678',900)
--update cardInfo set balance=balance-900 where customerID=1

--insert into transInfo(transDate,transType,cardID,transMoney) values(getdate(),'��ȡ','1010 3576 1212 1134',5000)
--update cardInfo set balance=balance+5000 where customerID=2

--update cardInfo set IsReportLoss=1 where cardID='1010 3576 1212 1134'
--update cardInfo set IsReportLoss=1 where cardID='1010 3576 1256 2235'


select * from userInfo 
select * from cardInfo
select * from transInfo

--�Զ����ɿ���
create  procedure  sp_randCardID
@randCardId char(19) output
as 
declare @ran numeric(16,8)
set @ran = rand((datepart(mm,getDate())*1000) + (datepart(ss,getDate())*1000) + datepart(ms,getdate()))
select @randCardId = '20190424' + SUBSTRING(CAST(@ran as varchar),3,4) + ''+ SUBSTRING(CAST(@ran as varchar),4,4)
go
declare @myCardId char(19)
execute sp_randCardID @myCardId output
print '�ҵĿ���Ϊ��'+@myCardId

--�����洢����

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
print 'alert�� money less 1 RMB'
go


--������
begin
begin  tran
declare @myCardId char(19),@error int
execute sp_randCardID @myCardId output
execute sp_openCount 'jokes',@myCardId,360731199805266583,15170038820,500,'123456','����������','����'
set @error = @@ERROR
if(@error > 0)
rollback TRANSACTION
else 
commit TRANSACTION
end

--��ǮȡǮ�洢����
exec sp_takeMoney 2019042413533536,50000,'��ȡ',123456
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
if(@transType = '��ȡ')
begin
print '�������ڴ��������ĵȴ�........'
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
print '���׳ɹ���'
print '���ţ�'+convert(varchar(50),@cardID)+ ',��'+convert(varchar(50),@balance)
end
else if(@error  > 0)
begin
rollback tran
print '����ʧ�ܣ�'
end
end
if(@transType = '֧ȡ')
begin
set @error = 0


print '�������ڴ����У������ĵȴ�........'
insert into transInfo (transDate,cardId,transType,transMoney)
values(GETDATE(),@cardID,@transType,@money)
set @error = @@ERROR
set @balance=@balance-@money
if(@balance < 0)
begin
print '����ʧ�ܣ������˻����㣡'
end
else
begin
update cardInfo set balance = @balance where cardID = @cardID
set @error = @error + @@ERROR
if(@error >0)
begin
rollback tran
print '����ʧ�ܣ�'
print '���ţ�'+convert(varchar(50),@cardID) + ',���Ϊ��'+convert(varchar(50),@balance)
end
else
begin
commit tran 
print '���׳ɹ���'
print '���ţ�'+convert(varchar(50),@cardID) + ',���Ϊ��'+convert(varchar(50),@balance)
end
end

end
end
else
print '�������'
end
else
begin
print '���Ų����ڣ������Ƿ�������ȷ'
set @error = 1
end
go

--ת�˴洢����
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
exec sp_takeMoney @cardID_owner,@transMoney,'֧ȡ',@openPass
set @error = @@ERROR
if(@error >0)
begin 
rollback tran
print '����ʧ�ܣ�'
end
else 
begin
  set @error = 0
  print 'ת�˽������ڴ����У���ȴ�......'
  declare @existCard int 
  select @existCard =COUNT(*)from cardInfo where cardID = @cardID_Got
  if(@existCard > 0)
  begin
  insert into transInfo (transDate,cardID,transType,transMoney)
  values(GETDATE(),@cardID_Got,'��ȡ',@transMoney)
  set @error =  @@ERROR
  declare @balance money
  select @balance = balance from cardInfo where cardID = @cardID_Got
  set @balance = @balance + @transMoney
  update cardInfo set balance = @balance where cardID = @cardID_Got
  set @error = @error + @@ERROR
  if(@error > 0)
  begin
  rollback tran 
  print '����ʧ�ܣ�'
  end
  else
  begin
  commit tran
  print '���׳ɹ������׽�'+ convert(varchar,@transMoney) + 'Ԫ'
  print '���ţ�'+convert(varchar,@cardID_Got) +'����'+convert(varchar,@balance)
  end
  end
  else
  begin
  rollback tran
  print '����ʧ�ܣ�ת�˿��Ų�����'
  end
end
go







