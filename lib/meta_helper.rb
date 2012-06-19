module MetaHelper

    def meta_description(*args)
        if args.empty?
            if @meta_description
                @meta_description
            else
                # Redmine::Info.app_name
                "cocos2d-x is a cross platform open source free 2D game engine for mobile gamedev, that is fast and stable, easy to learn and use"
            end
        elsif args.first.is_a?(String)
            @meta_description = args.first.gsub(%r{\n+}, ' ')
        end
    end

    def meta_keywords(*args)
        if args.empty?
            # @meta_keywords = %w(issue bug tracker) if @meta_keywords.blank?
            # @meta_keywords.select {|k| !k.blank? }.join(',')
            "cocos2d-x,cocos2d,game engine,opengl,cross,multi,platform,iphone,ipad,android,windows,metro,bada,marmalade,playbook"
        elsif args.first.is_a?(Array)
            @meta_keywords = args.first
        else
            @meta_keywords ||= []
            @meta_keywords += args
        end
    end

    def extract_keywords(text)
        strip_entities(text).scan(%r{[^\000-\100\133-\140\173-]{4,30}}i).inject({}) { |hash, word|
            keyword = word.downcase
            if hash.has_key?(keyword)
                hash[keyword] += 1
            else
                hash[keyword] = 1
            end
            hash
        }.sort{ |a, b| b[1] <=> a[1] }.collect{ |item| item[0] }.first(10)
    end

    def strip_textile(text, project = nil)
        text.gsub!(%r{\{\{[<>]?toc\}\}}i, '')
        plain = strip_tags(textilizable(text, :project => project))
        plain.gsub(%r{&(nbsp|para);}, ' ') # FIXME
    end

    def strip_entities(text)
        text.gsub(%r{&#?[a-z0-9]+;}i, '')
    end

end
