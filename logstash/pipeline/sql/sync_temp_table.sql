SELECT stores.*, images.saved_name FROM cookshoong_shop_dev.stores
join images on stores.store_image_id = images.image_id;
