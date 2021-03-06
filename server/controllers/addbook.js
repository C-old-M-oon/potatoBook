// 新增图书
// 1、获取豆瓣信息
// https://api.douban.com/v2/book/isbn/isbn
// 2、入库

const https = require('https')
const {mysql} = require('../qcloud')

module.exports = async (ctx) => {
  const {isbn, openId} = ctx.request.body
  // 添加之前先去数据库里面查询是否存在该图书
  if (isbn && openId) {
    const findRes = await mysql('books').select().where('isbn', isbn)
    if (findRes.length) {
      ctx.state = {
        code: -1,
        data: {
          msg: '图书已存在'
        }
      }
      return
    }
    let url = 'https://api.douban.com/v2/book/isbn/' + isbn
    const bookinfo = await getJSON(url)
    const rate = bookinfo.rating.average // 评分
    const {title, image, alt, publisher, summary, price} = bookinfo
    const tags = bookinfo.tags.map(v => {
      return `${v.title} ${v.count}`
    }).join(',')
    const author = bookinfo.author.join(',')
    // 向数据库中插入数据
    try {
      await mysql('books').insert({
        isbn, openId, title, image, alt, publisher, summary, price, rate, tags, author
      })
      ctx.state.data = {
        title,
        msg: 'success'
      }
    } catch (e) {
      ctx.state = {
        code: -1,
        data: {
          msg: '新增失败:' + e.sqlMessage
        }
      }
    }
    // console.log(bookinfo)
  }
}

function getJSON (url) {
  return new Promise ((resolve, reject) => {
    https.get(url, res => {
      let urlData = ''
      res.on('data', data => {
        urlData += data
      })
      res.on('end', data => {
        const bookinfo = JSON.parse(urlData)
        if (bookinfo.title) {
          resolve(bookinfo)
        }
        reject(bookinfo)
      })
    })
  })
}
