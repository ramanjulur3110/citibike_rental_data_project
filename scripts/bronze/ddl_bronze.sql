/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

if OBJECT_ID('bronze.citibike_tripduration', 'U') is not null
	drop table bronze.citibike_tripduration
create table bronze.citibike_tripduration(
	trip_duration int, 
	start_time DATETIME,
	stop_time DATETIME, 
	start_station_id int,
	start_station_name nvarchar(100),
	start_station_latitude Decimal(8,6),
	start_station_longitude Decimal(9,6),
	end_station_id int, 
	end_station_name nvarchar(100),
	end_station_latitude Decimal(8,6),
	end_station_longitude Decimal(9,6),
	bike_id int, 
	user_type nvarchar(50),
	birth_year nvarchar(10), 
	gender int
);
GO

if OBJECT_ID('bronze.citibike_weather', 'U') is not null
	drop table bronze.citibike_weather
create table bronze.citibike_weather(
	station nvarchar(100), 
	name varchar(255), 
	date DATE, 
	AWND FLOAT, 
	PRCP FLOAT, 
	SNOW FLOAT, 
	SNWD FLOAT, 
	TAVG INT, 
	TMAX INT, 
	TMIN INT, 
	WDF2 FLOAT, 
	WDF5 FLOAT, 
	WSF2 FLOAT, 
	WSF5 FLOAT
);
GO
