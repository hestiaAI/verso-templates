import VersoManual
import Report

open Verso.Genre Manual

def reportConfig : RenderConfig where
  emitTeX := true
  extraHead := #[Verso.Output.Html.tag "style" #[] <| .text false r##"
    :root {
      --report-teal: #287c78;
      --report-coral: #c86f5c;
      --report-gold: #d7b75a;
      --report-ink: #253839;
    }
    .titlepage {
      position: relative;
      isolation: isolate;
      overflow: hidden;
      text-align: left;
      border-block: 1px solid #d9e6e3;
      background: linear-gradient(105deg, #fff 0%, #fbfcfa 57%, #edf5f2 100%);
    }
    main .titlepage h1,
    main .titlepage .authors {
      max-width: 62%;
      text-align: left;
    }
    main .titlepage h1 {
      margin-left: 0;
      margin-right: auto;
      padding-top: 1rem;
      white-space: normal;
      text-wrap: balance;
    }
    main .titlepage .authors { margin-left: 0; }
    main .titlepage > p {
      width: 62%;
      max-width: 62%;
      margin: 0.35rem 0;
      padding: 0.3rem 0.7rem;
      border-inline-start: 2px solid #287c7833;
      background: #fff;
    }
    .titlepage::before,
    .titlepage::after {
      position: absolute;
      z-index: -1;
      content: "";
      pointer-events: none;
    }
    .titlepage::before {
      top: 0.5rem;
      right: 0.5rem;
      width: 36%;
      height: 14rem;
      background:
        radial-gradient(circle, transparent 0 34%, #287c7828 35% 42%, transparent 43%) 68% 20% / 8rem 8rem no-repeat,
        linear-gradient(135deg, transparent 0 48%, #c86f5c25 49% 62%, transparent 63%) 100% 100% / 11rem 11rem no-repeat,
        linear-gradient(45deg, transparent 0 43%, #d7b75a45 44% 61%, transparent 62%) 78% 78% / 6rem 6rem no-repeat,
        linear-gradient(135deg, #287c781b 0 24%, transparent 24% 100%) 100% 0 / 7rem 7rem no-repeat;
    }
    .titlepage::after {
      top: 1.25rem;
      right: 1.25rem;
      width: 5rem;
      height: 5rem;
      background: radial-gradient(circle, #287c7870 1.2px, transparent 1.6px);
      background-size: 9px 9px;
      clip-path: polygon(50% 0, 100% 0, 100% 50%, 50% 100%, 0 50%, 0 0);
      opacity: 0.48;
    }
    main .titlepage h1 { color: var(--report-ink); }
    .content-wrapper h2 {
      padding: 0.25rem 0.65rem;
      border-inline-start: 4px solid var(--report-teal);
      background: #287c780c;
    }
    .content-wrapper h3 { color: var(--report-coral); }
    @media (max-width: 700px) {
      main .titlepage h1,
      main .titlepage .authors,
      main .titlepage > p { width: 100%; max-width: 100%; }
      main .titlepage h1 { text-align: left; }
      .titlepage::before {
        top: 0.25rem;
        width: 34%;
        height: 6rem;
        opacity: 0.58;
        background-size: 4rem 4rem, 5rem 5rem, 3rem 3rem, 3.5rem 3.5rem;
      }
      .titlepage::after {
        top: 0.5rem;
        right: 0.5rem;
        width: 2.5rem;
        height: 2.5rem;
      }
    }
  "##]

def main := manualMain (%doc Report) (config := reportConfig)