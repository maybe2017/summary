import React, { Component } from "react";
import { NavLink } from "react-router-dom@5";

export default class MyNavLink extends Component {
  render() {
    // this.props中包含了标签属性对应的key-value，也包含了标签体(key固定为'children')，所以这里可以直接展开
    // 标签体内容也被视为 标签的一个属性(key固定为'children'), 可以默认向子组件传递
    console.log(this.props);
    return (
      <NavLink
        activeClassName="active"
        className="list-group-item"
        {...this.props}
      />
    );
  }
}
