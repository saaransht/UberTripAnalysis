
CREATE TABLE dbo.finaluberanalytics (
    trip_id INT,
    VendorID INT,
    tpep_pickup_datetime DATETIME,
    tpep_dropoff_datetime DATETIME,
    passenger_count INT,
    trip_distance FLOAT,
    rate_code_name VARCHAR(255),
    pickup_latitude FLOAT,
    pickup_longitude FLOAT,
    dropoff_latitude FLOAT,
    dropoff_longitude FLOAT,
    payment_type_name VARCHAR(255),
    fare_amount FLOAT,
    extra FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    improvement_surcharge FLOAT,
    total_amount FLOAT
);

INSERT INTO dbo.finaluberanalytics (
    trip_id,
    VendorID,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    rate_code_name,
    pickup_latitude,
    pickup_longitude,
    dropoff_latitude,
    dropoff_longitude,
    payment_type_name,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount
)
SELECT 
    f.trip_id,
    f.VendorID,
    d.tpep_pickup_datetime,
    d.tpep_dropoff_datetime,
    p.passenger_count,
    t.trip_distance,
    r.rate_code_name,
    pick.pickup_latitude,
    pick.pickup_longitude,
    dr.dropoff_latitude,
    dr.dropoff_longitude,
    pay.payment_type_name,
    f.fare_amount,
    f.extra,
    f.mta_tax,
    f.tip_amount,
    f.tolls_amount,
    f.improvement_surcharge,
    f.total_amount
FROM 
    dbo.facttable f
JOIN dbo.datetime_dim d ON f.datetime_id = d.datetime_id
JOIN dbo.passenger_count_dim p ON p.passenger_count_id = f.passenger_count_id  
JOIN dbo.trip_distance_dim t ON t.trip_distance_id = f.trip_distance_id  
JOIN dbo.rate_code_dim r ON r.rate_code_id = f.rate_code_id  
JOIN dbo.pickup_location_dim pick ON pick.pickup_location_id = f.pickup_location_id
JOIN dbo.dropoff_location_dim dr ON dr.dropoff_location_id = f.dropoff_location_id
JOIN dbo.payment_type_dim pay ON pay.payment_type_id = f.payment_type_id;
