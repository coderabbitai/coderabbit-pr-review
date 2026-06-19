type RowProps = {
  label: string;
  onSelect: () => void;
};

function Row({ label, onSelect }: RowProps) {
  return <span>{label}</span>;
}

export function AssertiveHints() {
  const handleAction = () => console.log("action");

  return (
    <section>
      <button>Save</button>
      <img src="/logo.png" />
      <div onClick={handleAction}>Open menu</div>
      <Row label="item-a" onSelect={() => console.log("selected")} />
    </section>
  );
}
