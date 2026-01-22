/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create or alter procedure bronze.load_bronze as 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE()
		PRINT ('=============================================================');
		PRINT ('Loading Bronze Layer');
		PRINT ('=============================================================');


		PRINT ('**************************************************************');
		Print ('Loading data into citibike_tripduration');
		PRINT ('**************************************************************');


		SET @start_time = GETDATE()
		PRINT ('>> Truncating Table: bronze.citibike_tripduration <<')
		TRUNCATE TABLE bronze.citibike_tripduration;
		PRINT ('>> Inserting Data Into: bronze.citibike_tripduration <<')
		bulk insert bronze.citibike_tripduration
		from 'C:\Users\Rakesh Ramanjulu\Documents\Python Project\bike-rental-starter-kit\bike-rental-starter-kit\data\citibike-tripdata-all.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE()
		print ('>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds')
		print ('----------------')
		

		PRINT ('**************************************************************');
		Print ('Loading data into citibike_weather');
		PRINT ('**************************************************************');

		SET @start_time = GETDATE()
		PRINT ('>> Truncating Table: bronze.citibike_weather <<')
		TRUNCATE TABLE bronze.citibike_weather;
		PRINT ('>> Inserting Data Into: bronze.citibike_weather <<')
		bulk insert bronze.citibike_weather
		from 'C:\Users\Rakesh Ramanjulu\Documents\Python Project\bike-rental-starter-kit\bike-rental-starter-kit\data\newark_airport_2016_cleaned.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE()
		print ('>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds')
		print ('----------------')
	END TRY
	BEGIN CATCH
		PRINT ('=============================================================');
		PRINT ('ERROR OCCURRED DURING LOADING BRONZE LAYER')
		PRINT ('ERROR MESSAGE: ') + ERROR_MESSAGE()
		PRINT ('ERROR NUMBER: ') + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT ('ERROR STATE: ') + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT ('=============================================================');
	END CATCH 
END
