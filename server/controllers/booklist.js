const { mysql } = require('../qcloud')
module.exports = async (ctx) => {
    const { pageNo, openId } = ctx.request.query
    const size = 10
    const mysqlSelect = mysql('books')
        .select('books.*', 'cSessioninfo.user_info')
        .join('cSessioninfo', 'books.openId', 'cSessioninfo.open_id')
        .orderBy('books.id', 'desc')
    let books
    if (openId) {
    // 个人添加的图书列表
        books = await mysqlSelect.where('books.openId', openId)
    } else {
    // 获取全部图书并分页
        books = await mysqlSelect
            .limit(size)
            .offset(Number(pageNo) * size)
    }
    ctx.state.data = {
        list: books.map(v => {
            const info = JSON.parse(v.user_info)
            return Object.assign({}, v, {
                user_info: {
                    nickName: info.nickName
                }
            })
        })
    }
}
