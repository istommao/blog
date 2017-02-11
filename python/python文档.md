title: python文档
date: 2017-02-08 16:10:00
tags:
- python
- doc

# python文档

## 举例

flask get_json 函数 文档：

    """Parses the incoming JSON request data and returns it.  By default
    this function will return ``None`` if the mimetype is not
    :mimetype:`application/json` but this can be overridden by the
    ``force`` parameter. If parsing fails the
    :meth:`on_json_loading_failed` method on the request object will be
    invoked.

    :param force: if set to ``True`` the mimetype is ignored.
    :param silent: if set to ``True`` this method will fail silently
                   and return ``None``.
    :param cache: if set to ``True`` the parsed JSON data is remembered
                  on the request.
    """

生成的文档：
<http://flask.pocoo.org/docs/0.12/api/#flask.Request.get_json>

