const { mysql } = require('../qcloud')

module.exports = async (ctx) => {
  const { bookid, openId } = ctx.request.query
  const mysqlSelect = mysql('comments')
                    .select('comments.*', 'cSessioninfo.user_info')
                    .join('cSessioninfo', 'comments.openId', 'cSessioninfo.open_id')
  let comments
  if (bookid) {
    // 单本书评论
    comments = await mysqlSelect.where('bookid', bookid)
  } else if (openId) {
    // 单个人所有评论
    comments = await mysqlSelect.where('openId', openId)
  }
  ctx.state.data = {
    list: comments.map(v => {
      const info = JSON.parse(v.user_info)
      return Object.assign({}, v, {
        title: info.nickName,
        image: info.avatarUrl
      })
    })
  }
}