# _plugins/sync_items_to_product.rb

require 'fileutils'

module Jekyll
  class SyncItemsToProduct < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      items_path = File.join(site.source, '_items')
      product_path = File.join(site.source, 'product')

      FileUtils.mkdir_p(product_path) unless Dir.exist?(product_path)
      FileUtils.rm_rf(Dir.glob(File.join(product_path, '*')))

      Dir.foreach(items_path) do |item|
        next if item == '.' || item == '..'
        src = File.join(items_path, item)
        dst = File.join(product_path, item)

        if File.file?(src) && File.extname(src) == '.html'
          puts "Copying #{src} to #{dst}"
          FileUtils.cp(src, dst)
        end
      end
    end
  end
end