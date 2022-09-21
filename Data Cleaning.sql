/*
Cleaning Data in SQL Queries
*/


select *
from [dbo].[NashvilleHousing]
 
--------------------------------------------------------------------------------------------------------------------------

--Standardize Date Format

select ConvertedSaleDate, convert(Date, saledate)
from [dbo].[NashvilleHousing]


update [dbo].[NashvilleHousing]
set saledate = convert(Date, saledate)


Alter table [dbo].[NashvilleHousing]
Add ConvertedSaleDate Date;


update [dbo].[NashvilleHousing]
set ConvertedSaleDate = convert(Date, saledate)


--------------------------------------------------------------------------------------------------------------------------

--Breaking out OwnerAddress into individual column (Address, city, State)

select Owneraddress
from [dbo].[NashvilleHousing]

select
Parsename(Replace(Owneraddress, ',', '.') ,3),
Parsename(Replace(Owneraddress, ',', '.') ,2),
Parsename(Replace(Owneraddress, ',', '.') ,1)
from [dbo].[NashvilleHousing]

Alter table [dbo].[NashvilleHousing]
Add Split_OwnerAddress nvarchar(255);

update [dbo].[NashvilleHousing]
set Split_OwnerAddress = Parsename(Replace(Owneraddress, ',', '.') ,3)


Alter table [dbo].[NashvilleHousing]
Add Split_OwnerCity nvarchar(255);

update [dbo].[NashvilleHousing]
set Split_OwnerCity = Parsename(Replace(Owneraddress, ',', '.') ,2)


Alter table [dbo].[NashvilleHousing]
Add Split_OwnerState nvarchar(255);

update [dbo].[NashvilleHousing]
set Split_OwnerState = Parsename(Replace(Owneraddress, ',', '.') ,1)


select *
from [dbo].[NashvilleHousing]

--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [dbo].[NashvilleHousing]
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [dbo].[NashvilleHousing]


Update [dbo].[NashvilleHousing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

--------------------------------------------------------------------------------------------------------------------------

--Remove Duplicates


WITH RowNumCTE AS(
	      Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [dbo].[NashvilleHousing]
)
select *
From RowNumCTE
Where row_num > 1
 Order by PropertyAddress

--------------------------------------------------------------------------------------------------------------------------
 
 -- Delete Unused Columns

 select *
 from [dbo].[NashvilleHousing]

 Alter table [dbo].[NashvilleHousing]
 Drop COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate





