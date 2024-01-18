export default function PersonProfile({ props }) {
  console.log(props);
  const { personList } = props;
  return (
    <div>
      <ol>
        {personList.map((item, index) => {
          return (
            <li key={index}>
              姓名:{item.name}, 年龄:{item.age}
            </li>
          );
        })}
      </ol>
    </div>
  );
}
