import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View,
    ScrollView,
    Image
} from 'react-native';

import Dimensions from 'Dimensions';
let screenWidth = Dimensions.get("window").width;


export default class ImageCell extends Component {
    render() {
        return(
            <View style={ styles.container }>
                <Image 
                source={{uri: 'cover'}} 
                style={styles.coverImage} 
                ></Image>
                <Text style={styles.redTitle} >今日福利</Text>
                <Text style={styles.headTitle} >喜迎春节，超值闪购低至3折！</Text>
                <Text style={styles.subTitle} >更多福利请进入活动页，一起HIGH起来吧！</Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        width: screenWidth,
        height: 255,
    },

    coverImage: {
        backgroundColor: 'yellow',
        width: screenWidth-30,
        height: 175,
        marginLeft: 15,
        borderRadius: 10,
        shadowColor: 'red',
        shadowOffset: {width: 2, height: 2},
        shadowOpacity: 1,
    },

    redTitle: {
        color: '#FE3131',
        marginTop: 5,
        marginLeft: 15,
    },

    headTitle: {
        marginLeft: 15,
        marginTop: 5,
        fontSize: 20,
        fontWeight: 'bold',
    },

    subTitle: {
        marginTop: 5,
        marginLeft: 15,
        color: '#9B9B9B',
    }
})