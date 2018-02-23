import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View,
    ScrollView
} from 'react-native';
import CarouselCell from './cell/carouselCell'
import SeparateLine from '../main/separateLine'
import TitleView from './View/titleView'
import Dimensions from 'Dimensions';
let screenWidth = Dimensions.get("window").width;

export default class HomePage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <ScrollView>
                    <CarouselCell></CarouselCell>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}/>
                    <TitleView 
                        headTile={'鲜肉驾到'}
                        subTile={'唯有鲜肉和爱情不能辜负!'} ></TitleView>
                </ScrollView>
            </View>
        );
    }
}


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F8F8F8'
    },
})

AppRegistry.registerComponent('Carte', () => HomePage)