class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :styles => { :content => '800>', :thumb => '118x100#'},
                    :storage => :s3,
                    :url => ":s3_domain_url",
                    :s3_credentials => {
                        :bucket => ENV['S3_BUCKET_NAME'],
                        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
                      

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
