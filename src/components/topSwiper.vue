<template>
  <div class="topSwiper">
    <swiper
      indicator-dots="true"
      indicator-color="#ea5a49"
      autoplay="true"
      duration="1000"
      circular="true">
      <div :key="imgindex" v-for="(top, imgindex) in imgUrls">
        <swiper-item>
          <img
            @click="bookDeail(img)"
            class="swiper-img"
            mode='aspectFit'
            :key="img.id"
            v-for="img in top"
            :src="img.image"
            alt="">
        </swiper-item>
      </div>
    </swiper>
  </div>
</template>

<script>
export default {
  props: {
    tops: {
      type: Array,
      default: []
    }
  },
  computed: {
    imgUrls () {
      let res = this.tops
      return [res.slice(0, 3), res.slice(3, 6), res.slice(6)]
    }
  },
  methods: {
    bookDeail (item) {
      wx.navigateTo({
        url: `/pages/detail/main?id=${item.id}`
      })
    }
  }
}
</script>

<style lang="scss">
  .topSwiper {
    margin-top: 5px;
    .swiper-img {
      width: 33%;
      height: 250rpx;
    }
  }
</style>

