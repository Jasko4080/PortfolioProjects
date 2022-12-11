SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

--Standardize Date Format

SELECT Saledateconverted, CONVERT(Date,Saledate)
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET Saledate = CONVERT(date,saledate)

ALTER TABLE NashvilleHousing
ADD SaledateConverted Date;

UPDATE NashvilleHousing
SET Saledateconverted = CONVERT(date,saledate)

--Populate property Address data

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.parcelID = b.parcelid
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET propertyaddress = ISNULL(a.propertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.parcelID = b.parcelid
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

--Breaking out Address Into Individual Columns (Address, City, State)

SELECT propertyaddress
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE propertyAddress IS NULL
--ORDER BY ParceID

SELECT
SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1) AS Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) AS Address
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))


SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

--Change Y and N Yes and No in 'Sold as Vacant' field

SELECT DISTINCT(soldasvacant), COUNT(soldasvacant)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT soldasvacant
,	CASE WHEN Soldasvacant = 'Y' THEN 'YES'
		WHEN Soldasvacant = 'N' THEN 'No'
		ELSE Soldasvacant
		END
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END

-- Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 Saleprice,
				 Saledate,
				 LegalReference
				 ORDER BY
				    UniqueID
					) row_num
				 
FROM PortfolioProject.dbo.NashvilleHousing
)
DELETE -- SELECT *
FROM RowNumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress


--Delete Unused Columns

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN SaleDate