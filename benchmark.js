var yantl = require('.');
var Benchmark = require('benchmark');
var suite = new Benchmark.Suite();
var multiline = require('multiline');

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


// add tests
suite.add('RegExp#test', function() {
  yantl.parse(template);
})
// add listeners
.on('cycle', function(event) {
  console.log(String(event.target));
})
.on('complete', function() {
  console.log('Fastest is ' + this.filter('fastest').pluck('name'));
})
// run async
.run({ 'async': true });