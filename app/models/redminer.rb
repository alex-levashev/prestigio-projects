class Redminer < ActiveRecord::Base

  require 'nokogiri'
  require 'net/http'
  require 'open-uri'

  scope :main, -> { where(:redmine_parent_id => nil) }
  scope :child, -> { where.not(:redmine_parent_id => nil) }

  def self.redmine_projects
    Redminer.delete_all
    limit=100
    offset = 0
    project_data = []
    redmine_url = "http://tracker.prestigio.com/"
    key = "55177b9b585eed73b05dc28437e3bef3cb2d2a42"

      xml = Nokogiri::XML(open("#{redmine_url}projects.xml?key=#{key}&limit=1"))
      total_count = xml.at('projects').attribute('total_count').value.to_i

      count = total_count/limit

      until offset > total_count do
        xml = Nokogiri::XML(open("#{redmine_url}projects.xml?key=#{key}&limit=#{limit}&offset=#{offset}"))
          xml.search('//project').each do |t|
            redmine = new
            redmine.redmine_id = t.at('id').inner_text.to_i
            redmine.redmine_project_name = t.at('name').inner_text.to_s
            redmine.redmine_parent_id = t.at('parent').attribute('id').value.to_i if t.at('parent').nil? == false
            redmine.save
          end
        offset = offset + limit
      end
  end

end
