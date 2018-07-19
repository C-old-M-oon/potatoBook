<template>
  <a :href="detailUrl">
    <div class="book-card">
      <div class="thumb" @click.stop="preview">
        <img :src="book.image" class="image" mode="aspectFit">
      </div>
      <div class="detail">
        <div class="row text-primary">
          <div class="left">
            {{book.title}}
          </div>
          <div class="right">
            {{book.rate}}<Rate :value="book.rate"></Rate>
          </div>
        </div>
        <div class="row">
          <div class="left">
            {{book.author}}
          </div>
          <div class="right text-primary">
            浏览量：{{book.count}}
          </div>
        </div>
        <div class="row">
          <div class="left">
            {{book.publisher}}
          </div>
          <div class="right">
            {{book.user_info.nickName}}
          </div>
        </div>
      </div>
    </div>
  </a>
</template>

<script>
  import Rate from './rate'
  export default {
    components: {
      Rate
    },
    props: {
      book: {
        type: Object,
        default: {}
      }
    },
    computed: {
      detailUrl () {
        // 路由跳转
        return '/pages/detail/main?id=' + this.book.id
      }
    },
    methods: {
      preview () {
        wx.previewImage({
          current: this.book.image,
          urls: [this.book.image]
        })
      }
    }
  }
</script>

<style lang="scss">
  .book-card {
    padding: 5px;
    overflow: hidden;
    margin: 5px 0;
    font-size: 14px;
    .thumb {
      width: 90px;
      height: 90px;
      float: left;
      margin: 0 auto;
      overflow: hidden;
      .image{
        max-width: 100%;
        max-height: 100%;
      }
    }
    .detail {
      margin-left: 100px;
      .row {
        line-height: 20px;
        margin-bottom: 3px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        .left {
          max-width: 60%;
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
        }
      }
    }
  }
</style>