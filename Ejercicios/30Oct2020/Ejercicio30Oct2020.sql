-- Sanchez Ramirez Noel Adan
------------------------------------------------------------------
begin
-- Multiplicaciones sucesivas sin tomar en cuenta datos decimales
	declare @m int = 6;
	declare @n int = 5;
	declare @multi int  = 0;
	while @n > 0  BEGIN
			set @multi += @m;
			set @n -= 1;
		END
	print @multi;
END
------------------------------------------------------------------
begin
-- Divisiones sucesivas sin tomar en cuenta datos decimales
	declare @mm int = 30;
	declare @nn int = 3;
	declare @div int  = 0;
	while @mm >= @nn  BEGIN
			set @div += 1;
			set @mm -= @nn;
		END
	print @div;
END