																			--Assignment 4--

--1).Create a stored procedure in the Northwind database that will calculate the average 
--value of Freight for a specified customer.Then, a business rule will be added that will 
--be triggered before every Update and Insert command in the Orders controller,and 
--will use the stored procedure to verify that the Freight does not exceed the average 
--freight. If it does, a message will be displayed and the command will be cancelled.
	--Stored Procedure AVG Freight

	CREATE OR ALTER PROCEDURE [dbo].[AVGFREIGHT]
	@CustomerID nchar(5),@AvgFreight money output
	AS BEGIN
	Select @AvgFreight = avg(freight)
	FROM  Orders
	WHERE CustomerID=@CustomerID
	END
	

	--EXEC [dbo].[AVGFREIGHT] @CustomerID='ALFKI' ,@AvgFreight=1.0

	--Trigger For Validation
		CREATE or ALTER trigger validationOfFreight
		On [Orders]
		FOR insert,update
		as 
		begin

		declare @avgFreight money;
		declare @CustomerID nchar(5);
		declare @freight	money;


		select @CustomerID = CustomerID , @freight = Freight
		from inserted;

		exec [dbo].[AVGFREIGHT] @CustomerID , @avgFreight Output

		IF @freight > @avgFreight
		begin 
			RAISERROR('Frieght should be less than the average freight', 16, 1);
			ROLLBACK TRANSACTION
		end
	end

--2). write a SQL query to Create Stored procedure in the Northwind database to retrieve Employee Sales by Country
	
	CREATE OR ALTER PROCEDURE [dbo].[EMPLOYEE_SALES_BY_COUNTRY]
	@country VARCHAR(100)
	AS
	BEGIN

	SELECT 
	E.EmployeeID,
	E.FirstName, 
	O.ShipCountry, 
	SUM([dbo].[Order Subtotals].[Subtotal]) AS TotalSale
    FROM [dbo].[Order Subtotals]
    INNER JOIN [dbo].[Orders] O
	ON
	[dbo].[Order Subtotals].[OrderID] = O.[OrderID]
    INNER JOIN Employees E 
	ON 
	O.[EmployeeID] = E.[EmployeeID]
    GROUP BY E.EmployeeID, O.ShipCountry,E.FirstName
	HAVING O.ShipCountry=@country
	END
	--EXEC [dbo].[EMPLOYEE_SALES_BY_COUNTRY] @country='Austria'

--3).write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales by Year
	
	CREATE OR ALTER PROCEDURE [dbo].[EMPLOYEE_SALES_BY_YEAR]
	@year date
	AS
	BEGIN
	SELECT 
	E.EmployeeID,
	E.FirstName, 
	YEAR(O.OrderDate),
	SUM([dbo].[Order Subtotals].[Subtotal])
    FROM [dbo].[Order Subtotals]
    INNER JOIN [dbo].[Orders] O
	ON
	[dbo].[Order Subtotals].[OrderID] = O.OrderID
    INNER JOIN Employees E 
	ON 
	O.[EmployeeID] = E.[EmployeeID]
    GROUP BY YEAR(O.OrderDate),	E.EmployeeID,
	E.FirstName
	HAVING YEAR(O.OrderDate)=YEAR(@year)
	ORDER BY E.EmployeeID
	END
	 
	--EXEC [dbo].[EMPLOYEE_SALES_BY_YEAR] @year='1996'

--4).write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales By Category
		CREATE OR ALTER PROCEDURE [dbo].[SALES_BY_CATEGORY]
		@categoryid int
		AS
		BEGIN
			SELECT						COUNT(p.ProductName) as TotalProducts,					SUM(od.UnitPrice * od.Quantity * (1-od.discount)) as Sales			FROM	Products AS p			inner	join					[dbo].[Order Details] as od			ON		od.ProductID = p.ProductID			WHERE	p.CategoryID = @categoryid			GROUP BY p.CategoryID			order by Sales desc
		END

	--EXEC [dbo].[SALES_BY_CATEGORY] @categoryid=2

--5).write a SQL query to Create Stored procedure in the Northwind database to retrieve Ten Most Expensive Products
	
		CREATE OR ALTER PROCEDURE [dbo].[TOP_TEN_EXPENSIVE_PRRODUCT]
		AS
		BEGIN
			SELECT TOP 10
			ProductName,UnitPrice
			FROM Products
			ORDER BY UnitPrice DESC
		END
	
	--EXEC [dbo].[TOP_TEN_EXPENSIVE_PRRODUCT]

	 set identity_insert "Orders" on


--6).write a SQL query to Create Stored procedure in the Northwind database to insert Customer Order Details 
		CREATE OR ALTER PROCEDURE [dbo].[Insert_On_Order_details]
		@OrderID int,
		@ProductID int,
		@UnitPrice money,
		@Quantity smallint,
		@Discount real
		AS BEGIN
		INSERT INTO [dbo].[Order Details]
		(
			OrderID,
			ProductID,
			UnitPrice,
			Quantity,
			Discount
		)
		VALUES
		(
			@OrderID,
			@ProductID,
			@UnitPrice,
			@Quantity,
			@Discount
		)
		END

	--EXEC  [dbo].[Insert_On_Order_details] @OrderID=11081,@ProductID=11,@UnitPrice=22,@Quantity=5,@Discount=0.11


--7)write a SQL query to Create Stored procedure in the Northwind database to update Customer Order Details
	
	CREATE OR ALTER PROCEDURE [dbo].[Update_on_Order_Details]
	@OrderID int,
	@ProductID int,
	@UnitPrice money,
	@Quantity smallint,
	@Discount real
	AS
	BEGIN
	UPDATE [dbo].[Order Details]
	SET
	ProductID=@ProductID,
	UnitPrice=@UnitPrice,
	Quantity=@Quantity,
	Discount=@Discount
	WHERE [dbo].[Order Details].[OrderID]=@OrderID
	END
--EXEC  [dbo].[Update_on_Order_Details] @OrderID=11081,@ProductID=11,@UnitPrice=220,@Quantity=55,@Discount=0.11