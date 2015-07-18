var yantl = require('../');
var multiline = require('multiline');

describe('test/yantl.test.js', function () {
  it('should ok', function () {
    true.should.ok;
  });

  it('should render', function () {
    var template = multiline(function () {
      /*
!doctype(html)
html(lang="en") {
  head {
    meta(charset="utf-8")
    title { "Yantl example" }
  }
  body {
    h1#title {
      "hello world"
    }
    h2(style="font-size: 0.75em;")#subtitle {
      "from Yanti"
    }
    section#content {
      "blah blah blah"
      "on the same line, blah blah blah";"bababa"
      "on a new line, blah blah blah"
    }
  }
}
      */
    });

    yantl.parse(template).should.equal(multiline(function() {
      /*
<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8"></meta>
<title>Yantl example</title></head>
<body><h1 id="title">hello world</h1>
<h2 style="font-size: 0.75em;"></h2>
<div id="subtitle">from Yanti</div>
<section id="content">blah blah blah
on the same line, blah blah blah
bababa
on a new line, blah blah blah</section></body></html>
      */
    }));
  });
});