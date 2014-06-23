
class Parser
  require 'nokogiri'

  def method_callseq
    "Regular methods"
  end


  def example_of_markup_code
    [" <pre> <!-- method.markup_code 290 -->", "               VALUE",
      "rb_ary_plus(VALUE x, VALUE y)", "{", "    VALUE z;", "    long len;", "",
      "    y = to_ary(y);", "    len = RARRAY_LEN(x) + RARRAY_LEN(y);",
      "    z = rb_ary_new2(len);",
      "    MEMCPY(RARRAY_PTR(z), RARRAY_PTR(x), VALUE, RARRAY_LEN(x));",
      "    MEMCPY(RARRAY_PTR(z) + RARRAY_LEN(x), RARRAY_PTR(y), VALUE,
      RARRAY_LEN(y));",
      "ARY_SET_LEN(z, len);",
      "return z;", "}", "            </pre>"]
  end

end
