{
  function buildtagidclass(htmltag, htmlid, htmlclass, htmlattrs) {
    var tag = htmltag ? htmltag : 'div';
    var id = htmlid ? ' id="' + htmlid + '"': '';
    var klass = htmlclass.length > 0 ? ' class="' + htmlclass + '"': '';
    var attrs = htmlattrs ? parsehtmlattrs(htmlattrs) : '';
    var start = '<' + tag + id + klass + attrs + '>';
    return ({
      start: start,
      end: '</' + tag + '>'
    })
  }

  function parsehtmlattrs(htmlattrs) {
    return ' ' + htmlattrs;
  }
}

start = htmldocument

htmldocument = doctype:doctype? htmlcontent:htmlcontent? {
  return [doctype, htmlcontent].join('\n')
}

doctype = "!doctype("i docspec:$([A-Za-z0-9_]+) ")" whitespace1 {
  if (docspec === 'html' || docspec === 'html5') {
    return "<!DOCTYPE html>"
  }
}

htmlcontent = content:(htmlblock/innercontent) whitespace {
  return content
}

innercontent =
  '"' content:$([^"]*) '"' semicolon:';'? {
    return content
  }

htmlblock = tagidclass:tagidclass whitespace '{' whitespace htmlcontent:htmlcontent* '}' {
  return tagidclass.start + htmlcontent.join('\n') + tagidclass.end
}
/ tagidclass:tagidclass {
  return tagidclass.start + tagidclass.end
}

tagidclass =
  htmltag:htmltag? htmlid:htmlid? htmlclass:htmlclass* htmlattrs:htmlattrs?
  !{return !htmltag && !htmlid && !htmlclass.length && !htmlattrs}
  {
    return buildtagidclass(htmltag, htmlid, htmlclass, htmlattrs);
  }

htmltag = tag:([A-Za-z0-9_-]+) {return tag.join('')}
htmlid = "#" id:([A-Za-z0-9_-]+) {return id.join('')}
htmlclass = '.' klass:([A-Za-z0-9_-]+) {return klass.join('')}
htmlattrs = '(' attrs:( [^)]* ) ')' {return attrs.join('')}


whitespace =
  [ \t\n\r]*
whitespace1 =
  [ \t\n\r]+

