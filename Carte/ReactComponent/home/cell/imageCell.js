import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    Image
} from 'react-native';

import Dimensions from 'Dimensions';
let screenWidth = Dimensions.get("window").width;


export default class ImageCell extends Component {
    render() {
        return(
            <View style={ styles.container }>
                <View style={ styles.imageView }>
                    <Image 
                    source={{uri: 'cover'}} 
                    style={styles.coverImage} 
                    ></Image>
                </View>
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

    imageView: {
        width: screenWidth-30,
        height: 175,
        marginLeft: 15,
        borderRadius: 10,
        elevation: 20,
        shadowColor: 'black',
        shadowOffset: {width: 2, height: 3},
        shadowOpacity: 0.2,
        shadowRadius: 1,
    },

    coverImage: {
        flex: 1,
        borderRadius: 10,
    },

    redTitle: {
        color: '#FE3131',
        marginTop: 5,
        marginLeft: 13,
    },

    headTitle: {
        marginLeft: 13,
        marginTop: 5,
        fontSize: 17,
        fontWeight: 'bold',
    },

    subTitle: {
        marginTop: 5,
        marginLeft: 11,
        color: '#9B9B9B',
    }
})