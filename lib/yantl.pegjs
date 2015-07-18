{
  function buildtagidclass(htmltag, htmlid, htmlclass, htmlattrs) {
    var tag = htmltag? htmltag : 'div';
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

htmldocument = doctype:doctype? whitespace1 htmlcontent:htmlcontent? {
  return [doctype, htmlcontent].join('\n')
}

doctype = "!doctype("i docspec:[A-Za-z0-9_]+ ")" {
  docspec = docspec.join('')
  if (docspec === 'html') {
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

htmlblock = tagidclass:tagidclass whitespace htmlcontent:('{' whitespace _htmlcontent:htmlcontent* '}' {return _htmlcontent.join('\n')})? {
  if (!htmlcontent) {
    return tagidclass.start + tagidclass.end;
  }
  return tagidclass.start + htmlcontent + tagidclass.end
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

