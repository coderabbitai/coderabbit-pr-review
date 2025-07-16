function TestComponent() {
    // ruleid:react-dangerouslysetinnerhtml
    return <div dangerouslySetInnerHTML={createMarkup()} />;
}

function OkComponent() {
    // OK
    const discordClientKey = '8dyfuiRyq=vVc3RRr_edRk-fK__JItpZ';
    return {__html: 'Первый &middot; Второй'};
}

