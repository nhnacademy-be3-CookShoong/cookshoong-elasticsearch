SELECT stores.*, images.saved_name, addresses.latitude, addresses.longitude, GROUP_CONCAT(menu.name) as menus
FROM cookshoong_shop_dev.stores
         join images on stores.store_image_id = images.image_id
         join addresses on stores.address_id = addresses.address_id
         join menu on stores.store_id = menu.store_id
GROUP BY stores.store_id;
