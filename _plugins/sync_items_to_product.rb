# _plugins/sync_items_to_product.rb

module Jekyll
  class SyncItemsToProduct < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      # Path folder
      items_path = File.join(site.source, '_items')
      product_path = File.join(site.source, 'product')

      # Pastikan folder product ada
      FileUtils.mkdir_p(product_path) unless Dir.exist?(product_path)

      # Hapus semua isi di product sebelum copy
      FileUtils.rm_rf(Dir.glob(File.join(product_path, '*')))

      # Copy file dari _items ke product
      Dir.foreach(items_path) do |item|
        next if item == '.' || item == '..'
        src = File.join(items_path, item)
        dst = File.join(product_path, item)

        if File.directory?(src)
          FileUtils.cp_r(src, dst)
        else
          FileUtils.cp(src, dst)
        end
      end
    end
  end
end