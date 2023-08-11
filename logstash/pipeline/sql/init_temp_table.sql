SELECT stores.*,
       images.saved_name,
       images.location_code,
       images.domain_name,
       addresses.latitude as lat,
       addresses.longitude as lon,
       addresses.main_place as place,
       GROUP_CONCAT(menu.name) as menus,
       GROUP_CONCAT(DISTINCT store_categories.description) as categories,
       MIN(menu.cooking_time) as minimum_cooking_time
FROM cookshoong_shop_dev.stores
         join images on stores.store_image_id = images.image_id
         join addresses on stores.address_id = addresses.address_id
         left join menu on stores.store_id = menu.store_id
         left join stores_has_categories on stores.store_id = stores_has_categories.store_id
         left join store_categories on stores_has_categories.category_code = store_categories.category_code
GROUP BY stores.store_id
