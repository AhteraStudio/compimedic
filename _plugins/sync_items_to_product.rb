# _plugins/sync_items_to_product.rb

require 'fileutils'
require 'yaml'

module Jekyll
  class SyncItemsToProduct < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      # Path folder
      items_path = File.join(site.source, '_items')
      product_path = File.join(site.source, 'product')

      # Pastikan folder /product ada
      FileUtils.mkdir_p(product_path) unless Dir.exist?(product_path)

      # Hapus semua file di /product sebelum copy
      FileUtils.rm_rf(Dir.glob(File.join(product_path, '*')))

      # Copy file .html dari _items ke /product
      Dir.foreach(items_path) do |item|
        next if item == '.' || item == '..'
        src = File.join(items_path, item)
        dst = File.join(product_path, item)

        if File.file?(src) && File.extname(src) == '.html'
          # Baca metadata YAML dari file
          content = File.read(src)
          yaml_part = content.split("---").reject(&:empty?).first

          # Tulis ulang file ke /product
          File.open(dst, 'w') do |file|
            file.write(content)
          end
        end
      end
    end
  end
end