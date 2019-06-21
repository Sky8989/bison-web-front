<template>
    <div>
        <searchfor></searchfor>
    </div>
</template>
<script>
export default {
    components: {
        searchfor: resolve =>
      require(["components/shippingRefund/opts/ship-searchfor.vue"], resolve),
    }
}
</script>
