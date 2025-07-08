
----- Data Cleaning

SELECT *
	FROM dbo.tech_layoffs;


SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tech_layoffs';
	SELECT DB_NAME() AS CurrentDatabase;

-- To Do List/Tasks
	-- 1. Remove Duplicates
	-- 2. Standardise the Data
	-- 3. Null Vlues or Blank Values
	-- 4. Drop columns or Rows


----------- Removing Duplicates -------------

SELECT *
	FROM tech_layoffs

SELECT *
	INTO stg_layoffs
		FROM tech_layoffs;

SELECT *
	FROM stg_layoffs


SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY #, Company, Location_HQ, Country, Continent,
			Laid_Off, Date_layoffs, Percentage, Industry, Stage,
			Money_Raised_in_$_mil 
	ORDER BY #) AS row_num
FROM stg_layoffs;




WITH duplicate_cte AS 
	(SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY Company, Location_HQ, Country, Continent,
				Laid_Off, Date_layoffs, Percentage, Industry, Stage,
					Money_Raised_in_$_mil
		ORDER BY #) AS row_num
	FROM stg_layoffs)
SELECT*
	FROM duplicate_cte
	WHERE row_num > 1;



SELECT *
	FROM stg_layoffs
		WHERE Company = 'Enphase Energy'



WITH duplicate_cte AS 
	(SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY Company, Location_HQ, Country, Continent,
				Laid_Off, Date_layoffs, Percentage, Industry, Stage,
						Money_Raised_in_$_mil
		ORDER BY #) AS row_num
	FROM stg_layoffs
	)
	DELETE FROM stg_layoffs
		WHERE # IN (
			SELECT # FROM duplicate_cte 
				WHERE row_num > 1
				);


SELECT *
FROM stg_layoffs


-----------   Standardizing Data   -------------

SELECT Company, TRIM(Company)
	FROM stg_layoffs;


UPDATE stg_layoffs
SET Company = TRIM(Company);

SELECT DISTINCT Industry
	FROM stg_layoffs
		ORDER BY 1 ;

SELECT *
	FROM stg_layoffs 
		WHERE Industry LIKE 'Travel%';

UPDATE stg_layoffs
	SET Industry = 'Manufacturing'
		WHERE Industry LIKE 'Manufac%' ;


SELECT Date_layoffs
	FROM stg_layoffs;

SELECT *
	FROM stg_layoffs
		WHERE Laid_off IS NULL
			AND Percentage IS NULL ;

DELETE
	FROM stg_layoffs
		WHERE Laid_off IS NULL
			AND Percentage IS NULL ;

SELECT *
	FROM stg_layoffs ;








 
