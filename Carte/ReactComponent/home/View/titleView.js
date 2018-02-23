import React, { Component } from 'react';
import { 
    View,
    StyleSheet,
    Text,
    Button,
    Animated
} from 'react-native';

export default class TitleView extends Component {

    constructor(props) {
        super(props);
        this.state = {
            headTile: props.headTile,
            subTitle: props.subTile,
        }
    }

    render() {
        return(
            <View style={styles.container}>
                <View style={styles.title}>
                    <Text style={ styles.headTitle }>{this.state.headTile}</Text>
                    <Text style={ styles.subTile }>{this.state.subTitle}</Text>
                </View>
                <Button 
                    style={ styles.seeMoreButton } 
                    title='查看更多' 
                    color='#D0021B'
                    onPress={this.click}
                    ></Button>
            </View>
        );
    }

    click() {
        console.log('点击')
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        height: 80,
    },

    title: {
        flex: 8,
        marginTop: 10,
        marginLeft: 15,
    },

    headTitle: {
        fontSize: 20,
        fontWeight: 'bold',
    },

    subTile: {
        color: '#9B9B9B',
        marginTop: 5,
    },

    seeMoreButton: {
        flex: 3,
        fontSize: 11,
        marginTop: 15,
    }
})