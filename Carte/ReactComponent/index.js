import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View
} from 'react-native';

const instructions = Platform.select({
                                     ios: 'Press Cmd+R to reload,\n' +
                                     'Cmd+D or shake for dev menu',
                                     android: 'Double tap R on your keyboard to reload,\n' +
                                     'Shake or press menu button for dev menu',
                                     });

export default class App extends Component<{}> {
    render() {
        return (
                <View style={styles.container}>
                <Text style={styles.welcome}>
                    //这里的name 和 age 就是从原生界面传过来的数据
                    我的名字是:{this.props.name}
                </Text>
                <Text style={styles.welcome}>
                我今年{this.props.age}岁
                </Text>
                <Text style={styles.instructions}>
                {instructions}
                </Text>
                </View>
                );
    }
}

const styles = StyleSheet.create({
                                 container: {
                                 flex: 1,
                                 justifyContent: 'center',
                                 alignItems: 'center',
                                 backgroundColor: '#F5FCFF',
                                 },
                                 welcome: {
                                 fontSize: 20,
                                 textAlign: 'center',
                                 margin: 10,
                                 },
                                 instructions: {
                                 textAlign: 'center',
                                 color: '#333333',
                                 marginBottom: 5,
                                 },
                                 });
                                 
AppRegistry.registerComponent('Carte', () => App);
