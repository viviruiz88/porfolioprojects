
--SELECT DATA SOBRE SINIESTRALIDAD

SELECT Poliza, Contratante, Pagado, [Fecha de pago], [No de siniestro], Certificado, Padecimiento, Sexo, [Fecha nacimiento], Especialidad
FROM [Proyecto Arco].dbo.Siniestralidad$

--PARA ESTANDARIZAR FORMATO FECHA

SELECT [Fecha de pago], [Fecha nacimiento],
CONVERT(Date,[Fecha de pago]) AS FechaDePago, CONVERT(Date, [Fecha nacimiento]) AS Fecha_De_Nacimiento
FROM [Proyecto Arco].dbo.Siniestralidad$

---PARA GENERAR ID UNICO

SELECT [Fecha nacimiento], Certificado,
YEAR ([Fecha nacimiento]) AS A�oNacimiento, MONTH ([Fecha nacimiento]) AS Mes_Nacimiento, DAY ([Fecha nacimiento]) AS D�a_Nacimiento, 
CONCAT(Certificado, YEAR ([Fecha nacimiento]), MONTH ([Fecha nacimiento]),  DAY ([Fecha nacimiento])) AS ID_Unico
FROM [Proyecto Arco].dbo.Siniestralidad$

---PARA EXTRAER MES Y ANO DE PAGO

SELECT [Fecha de pago],
YEAR ([Fecha de pago]) AS A�o_de_Pago, MONTH ([Fecha de pago]) AS Mes_de_Pago
FROM [Proyecto Arco].dbo.Siniestralidad$

---PARA GENERAR PADECIMIENTO ABREVIADO

SELECT Padecimiento, 
LEFT (Padecimiento,40) AS Padecimiento_Abreviado
FROM [Proyecto Arco].dbo.Siniestralidad$

---SINIESTRALIDAD FINAL PARA POWER BI

SELECT Poliza, Contratante, Pagado, CONVERT(Date,[Fecha de pago]) AS Fecha_De_Pago, [No de siniestro], Certificado, 
LEFT (Padecimiento,40) AS Padecimiento_Abreviado, Sexo, CONVERT(Date, [Fecha nacimiento]) AS Fecha_De_Nacimiento, Especialidad, 
YEAR ([Fecha nacimiento]) AS A�o_Nacimiento, MONTH ([Fecha nacimiento]) AS Mes_Nacimiento, DAY ([Fecha nacimiento]) AS D�a_Nacimiento, 
CONCAT(Certificado, YEAR ([Fecha nacimiento]), MONTH ([Fecha nacimiento]),  DAY ([Fecha nacimiento])) AS ID_Unico,
YEAR ([Fecha de pago]) AS A�o_de_Pago, MONTH ([Fecha de pago]) AS Mes_de_Pago
FROM [Proyecto Arco].dbo.Siniestralidad$


---RESUMEN POLIZA FINAL PARA POWER BI
SELECT P�liza, Contratante, Categor�a2 AS Categoria, Subgrupo, CONCAT(P�liza, Subgrupo) AS PolizaSubgrupo
INTO Polizas
FROM [Proyecto Arco].dbo.['Resumen polizas$']


SELECT *
FROM Polizas

---PARA EXTRAER INFORMACI�N Y GENERAR ID UNICO
SELECT Poliza, Subgrupo, [No# de Empleado], [Fecha de Nacimiento],[Fecha de Antig�edad],
YEAR ([Fecha de Nacimiento]) AS A�oNacimiento, MONTH ([Fecha de Nacimiento]) AS MesNacimiento, DAY ([Fecha de Nacimiento]) AS D�aNacimiento, 
CONCAT([No# de Empleado], YEAR ([Fecha de Nacimiento]), MONTH ([Fecha de Nacimiento]),  DAY ([Fecha de Nacimiento])) AS ID_Unico, 
CONCAT(Poliza, Subgrupo) AS Poliza_Subgrupo,
YEAR ([Fecha de Antig�edad]) AS A�oDeAntig�edad
FROM [Proyecto Arco].dbo.['Detalle de poblaci�n asegurada$']


---PARA CALCULAR LA EDAD ACTUAL DE LA POBLACI�N ASEGURADA 
SELECT [No# de Empleado], Categoria,[Fecha de Nacimiento], [Sexo del Asegurado],
DATEDIFF(YYYY,[Fecha de Nacimiento],'2021-08-01') as Edad
FROM [Proyecto Arco].dbo.['Detalle de poblaci�n asegurada$']
ORDER BY DATEDIFF(YYYY,[Fecha de Nacimiento], CONVERT (DATE, GETDATE())  );

---PARA RANGO DE EDAD
SELECT [No# de Empleado], Categoria,[Fecha de Nacimiento], [Sexo del Asegurado],
DATEDIFF(YYYY,[Fecha de Nacimiento],'2021-08-01') as Edad,
CASE 
WHEN Edad BETWEEN 0 AND 4 THEN '00-04'
WHEN Edad BETWEEN 5 AND 9 THEN '05-09'
WHEN Edad BETWEEN 10 AND 14 THEN '10-14'
WHEN Edad BETWEEN 15 AND 19 THEN '15-19'
WHEN Edad BETWEEN 20 AND 24 THEN '20-24'
WHEN Edad BETWEEN 25 AND 29 THEN '25-29'
WHEN Edad BETWEEN 30 AND 34 THEN '30-34'
WHEN Edad BETWEEN 35 AND 39 THEN '35-39'
WHEN Edad BETWEEN 40 AND 44 THEN '40-44'
WHEN Edad BETWEEN 45 AND 49 THEN '45-49'
WHEN Edad BETWEEN 50 AND 54 THEN '50-54'
WHEN Edad BETWEEN 55 AND 59 THEN '55-59'
WHEN Edad BETWEEN 60 AND 64 THEN '60-64'
WHEN Edad BETWEEN 65 AND 69 THEN '65-69'
WHEN Edad BETWEEN 70 AND 74 THEN '70-74'
WHEN Edad BETWEEN 75 AND 79 THEN '75-79'
WHEN Edad BETWEEN 80 AND 84 THEN '80-84'
WHEN Edad BETWEEN 85 AND 89 THEN '85-89'
WHEN Edad BETWEEN 90 AND 94 THEN '90-94'
WHEN Edad BETWEEN 95 AND 99 THEN '95-99'
ELSE ' '
END AS Rango_Edad
FROM [Proyecto Arco].dbo.['Detalle de poblaci�n asegurada$']


-- DETALLE DE POBLACI�N ASEGURADA ACTUAL FINAL PARA POWER BI
SELECT Poliza, Subgrupo,  [No# de Empleado], Categoria,[Fecha de Nacimiento],[Fecha de Antig�edad], [Sexo del Asegurado],
YEAR ([Fecha de Nacimiento]) AS A�oNacimiento, MONTH ([Fecha de Nacimiento]) AS MesNacimiento, DAY ([Fecha de Nacimiento]) AS D�aNacimiento, 
CONCAT([No# de Empleado], YEAR ([Fecha de Nacimiento]), MONTH ([Fecha de Nacimiento]),  DAY ([Fecha de Nacimiento])) AS ID_Unico, 
CONCAT(Poliza, Subgrupo) AS Poliza_Subgrupo,
YEAR ([Fecha de Antig�edad]) AS A�oDeAntig�edad,
DATEDIFF(YYYY,[Fecha de Nacimiento],'2021-08-01') as Edad,
CASE 
WHEN Edad BETWEEN 0 AND 4 THEN '00-04'
WHEN Edad BETWEEN 5 AND 9 THEN '05-09'
WHEN Edad BETWEEN 10 AND 14 THEN '10-14'
WHEN Edad BETWEEN 15 AND 19 THEN '15-19'
WHEN Edad BETWEEN 20 AND 24 THEN '20-24'
WHEN Edad BETWEEN 25 AND 29 THEN '25-29'
WHEN Edad BETWEEN 30 AND 34 THEN '30-34'
WHEN Edad BETWEEN 35 AND 39 THEN '35-39'
WHEN Edad BETWEEN 40 AND 44 THEN '40-44'
WHEN Edad BETWEEN 45 AND 49 THEN '45-49'
WHEN Edad BETWEEN 50 AND 54 THEN '50-54'
WHEN Edad BETWEEN 55 AND 59 THEN '55-59'
WHEN Edad BETWEEN 60 AND 64 THEN '60-64'
WHEN Edad BETWEEN 65 AND 69 THEN '65-69'
WHEN Edad BETWEEN 70 AND 74 THEN '70-74'
WHEN Edad BETWEEN 75 AND 79 THEN '75-79'
WHEN Edad BETWEEN 80 AND 84 THEN '80-84'
WHEN Edad BETWEEN 85 AND 89 THEN '85-89'
WHEN Edad BETWEEN 90 AND 94 THEN '90-94'
WHEN Edad BETWEEN 95 AND 99 THEN '95-99'
ELSE ' '
END AS Rango_Edad
FROM [Proyecto Arco].dbo.['Detalle de poblaci�n asegurada$']
ORDER BY DATEDIFF(YYYY,[Fecha de Nacimiento], CONVERT (DATE, GETDATE())  );

---TABLA PUENTE CONTRATANTE
SELECT DISTINCT(Contratante)
FROM [Proyecto Arco].dbo.['Resumen polizas$']

---TABLA POBLACION 2015

SELECT [Fecha de Nacimiento],[Sexo del Asegurado], Poliza_subgrupo, [Fecha de Antig�edad],
DATEDIFF(YYYY,[Fecha de Nacimiento],'2015-04-01') as Edad
INTO Poblacion2015
FROM [Proyecto Arco].dbo.[Poblacion asegurada]
WHERE DATEDIFF(YYYY,[Fecha de Nacimiento],'2015-04-01')>=0
AND [Fecha de Antig�edad]<='2015-04-01'


---TABLA POBLACION 2016
SELECT [Fecha de Nacimiento], [Sexo del Asegurado], Poliza_subgrupo, [Fecha de Antig�edad],
DATEDIFF(YYYY,[Fecha de Nacimiento],'2016-04-01') as Edad
INTO Poblacion2016
FROM [Proyecto Arco].dbo.[Poblacion asegurada]
WHERE DATEDIFF(YYYY,[Fecha de Nacimiento],'2016-04-01')>=0
AND [Fecha de Antig�edad]<='2016-04-01'

---TABLA POBLACION 2017
SELECT [Fecha de Nacimiento], [Sexo del Asegurado], Poliza_subgrupo, [Fecha de Antig�edad],
DATEDIFF(YYYY,[Fecha de Nacimiento],'2017-04-01') as Edad
INTO Poblacion2017
FROM [Proyecto Arco].dbo.[Poblacion asegurada]
WHERE DATEDIFF(YYYY,[Fecha de Nacimiento],'2017-04-01')>=0
AND [Fecha de Antig�edad]<='2017-04-01'

---TABLA POBLACION HISTORICA 2015 al 2017
SELECT * 
FROM [Proyecto Arco].dbo.Poblacion2015
UNION ALL
SELECT * 
FROM [Proyecto Arco].dbo.Poblacion2016
UNION ALL
SELECT * 
FROM [Proyecto Arco].dbo.Poblacion2017


--Poblacion hist�rica con empresa

SELECT [Fecha de Nacimiento], [Sexo del Asegurado], Poliza_Subgrupo, [Fecha de Antig�edad], Edad, Contratante
FROM [Proyecto Arco].dbo.[Poblacion historica] A
LEFT JOIN [Proyecto Arco].dbo.[Polizas] B
ON A.Poliza_subgrupo = B.PolizaSubgrupo


---CONTEO DE JUBILADOS PARA EL A�O 2015
SELECT COUNT([Id unico]) AS Jubilados2015
FROM [Proyecto Arco].dbo.['Detalle de poblaci�n asegurada$']
WHERE YEAR([Fecha de Antig�edad]) <= 2015
AND Categoria = 'JUBILADOS'


---TOTAL SINIESTROS
SELECT COUNT(DISTINCT([No de siniestro])) as ConteoSiniestros
FROM [Proyecto Arco].dbo.Siniestralidad$

---PARA CREAR UNA VISTA CON LOS COSTOS TOTALES DEL PADECIMIENTO POR AFILIADO
CREATE VIEW CostosTotalesPadecimientos AS
SELECT distinct([No de siniestro]), SUM(pagado) AS CostoSIniestro, Especialidad, Padecimiento
FROM [Proyecto Arco].dbo.Siniestralidad$
GROUP BY [No de siniestro], Especialidad, Padecimiento

SELECT *
FROM CostosTotalesPadecimientos

