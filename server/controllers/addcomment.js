const { mysql } = require('../qcloud')

module.exports = async (ctx) => {
  const {bookid, comment, openId, location, phone} = ctx.request.body
  try {
    await mysql('comments').insert({
      bookid,
      comment,
      openId,
      location,
      phone
    })
  } catch (e) {
    ctx.state = {
      code: -1,
      data: {
        msg: '评论失败:' + sql.sqlMessage
      }
    }
  }
}