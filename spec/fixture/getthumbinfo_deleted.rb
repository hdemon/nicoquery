module Fixture
  def self.getthumbinfo_deleted
    <<-EOS
<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<nicovideo_thumb_response status=\"fail\">\n<error>\n<code>DELETED</code>\n<description>deleted</description>\n</error>\n</nicovideo_thumb_response>
    EOS
  end
end