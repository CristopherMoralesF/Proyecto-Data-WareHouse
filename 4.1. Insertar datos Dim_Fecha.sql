USE FARMACIA_DW
GO


declare
   @StartDate datetime,
   @EndDate datetime
   set @StartDate = convert(datetime, '01/01/1900', 103)
   set @EndDate   = convert(datetime, '31/12/2050', 103)
   SET LANGUAGE English
   while @StartDate <= @EndDate begin
      insert
            into DIM_Fecha(FEC_ID,
                       FEC_FECHA,
                       FEC_DIA_SEMANA,
                       FEC_DIA_SEMANA_ENG,
                       FEC_DIA_MES,
                       FEC_DIA_PERIODO,
                       FEC_SEMANA,
                       FEC_NOMBRE_MES_ING,
                       FEC_MES,
                       FEC_TRIMESTRE,
                       FEC_PERIODO,
                       FEC_SEMESTRE,
                       FEC_SEMANA_PERIODO,
                       FEC_MES_PERIODO,
                       FEC_TRIMESTRE_PERIODO,
                       FEC_SEMESTRE_PERIODO)
      values ((DATEPART(year , @StartDate) * 10000) + (DATEPART(month , @StartDate)*100) + DATEPART(day , @StartDate),
              @StartDate,
              DATEPART(dw , @StartDate),
              DATENAME(dw, @StartDate),
              DATEPART(day , @StartDate),
              DATEPART(dayofyear , @StartDate),
              DATEPART(wk , @StartDate),
              DATENAME(month, @StartDate),
              DATEPART(month , @StartDate),
              DATEPART(quarter , @StartDate),
              DATEPART(year , @StartDate),
              CASE WHEN DATEPART(quarter , @StartDate) < 3 THEN 1 ELSE 2 END,
              CAST(DATEPART(year , @StartDate) as char(4)) + '-' + RIGHT('0'+CAST(DATEPART(wk , @StartDate) AS varchar(2)),2),
              CAST(DATEPART(year , @StartDate) as char(4)) + '-' + RIGHT('0'+CAST(DATEPART(month , @StartDate) AS varchar(2)),2),
              CAST(DATEPART(year , @StartDate) as char(4)) + '-' + CAST(DATEPART(quarter , @StartDate) AS varchar(1)),
              CAST(DATEPART(year , @StartDate) as char(4)) + '-' +
                          CAST(CASE WHEN DATEPART(quarter , @StartDate) < 3 THEN 1 ELSE 2 END AS char(2)))
      set @StartDate = dateadd(day,1,@StartDate)
   end
GO

SET LANGUAGE Spanish

UPDATE DIM_Fecha
   SET FEC_DIA_SEMANA_ESP = DATENAME(dw, FEC_FECHA),
       FEC_NOMBRE_MES_ESP = DATENAME(month, FEC_FECHA)
GO

SELECT * FROM FARMACIA_DW.DBO.DIM_FECHA
GO