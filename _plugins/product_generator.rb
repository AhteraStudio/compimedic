module Jekyll
  class ProductPageGenerator < Generator
    safe true

    def generate(site)
      site.collections['items'].docs.each do |item|
        path = "/product/#{item.basename_without_ext}.html"
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
      self.read_yaml(File.join(base, '_layouts'), 'default.html') # Sesuaikan layout kalo perlu
      self.data['title'] = item.data['title']
      self.data['content'] = item.content
      self.data.merge!(item.data) # Merge semua data dari _items
    end
  end
end
