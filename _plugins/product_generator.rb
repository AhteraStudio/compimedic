module Jekyll
  class ProductPageGenerator < Generator
    safe true

    def generate(site)
      items = site.collections['items']
      if items.nil?
        puts "Collection 'items' not found."
        return
      end

      puts "Total items found: #{items.docs.size}"  # Debugging
      items.docs.each do |item|
        path = "/product/#{item.basename_without_ext}.html"
        puts "Generating: #{path}"  # Debugging
        site.pages << ProductPage.new(site, site.source, path, item)
      end
    end
  end

  class ProductPage < Page
    def initialize(site, base, path, item)
      @site = site
      @base = base
      @dir  = File.dirname(path)
      @name = File.basename(path)

      self.process(@name)
      # Load content directly from the HTML file in _items
      self.content = item.content
      self.data.merge!(item.data) # Merge all metadata from the _items file
    end
  end
end