import React, { Component } from 'react';
import { 
    StyleSheet,
    View,
    Text,
    Image,
 } from 'react-native';
 import TitleView from "../View/TitleView.js";

 export default class MiddleCell extends Component {
     render() {
         return (
             <View style={styles.container}>
                 <TitleView 
                    headTile={'鲜肉驾到'}
                    subTile={'唯有鲜肉和爱情不能辜负!'}
                    ></TitleView>
                <View style={styles.bottom}>
                    <Image 
                        source={{uri: 'meet'}}
                        style={styles.backgroundImage} >
                    </Image>
                    <View style={styles.content}>
                        <Text
                            style={{
                                textAlign: 'center',
                                color: 'white',
                                fontSize: 16,
                            }}
                            >我能想到最浪漫的事就是和你一起吃肉</Text>
                        <Text
                            style={{
                                textAlign: 'center',
                                color: 'white',
                                fontSize: 16,
                                marginTop: 10,
                            }}
                            >超值低价神户牛肉抢购中…</Text>
                    </View>
                </View>
             </View>
         );
     }
 }

const styles = StyleSheet.create({
    container: {

    },

    bottom: {
        height: 180,
    },

    backgroundImage: {
        marginLeft: 15,
        marginRight: 15,
        height: 175,
    },

    content: {
        position: 'relative',
        top: -105,
        backgroundColor: 'transparent',
    },
})