module Fixture
  def self.getthumbinfo_notfound
    <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<nicovideo_thumb_response status="fail">
<error>
<code>NOT_FOUND</code>
<description>not found or invalid</description>
</error>
</nicovideo_thumb_response>
    EOS
  end
end
